#Requires -Version 5.1

$script:DefaultVmName = 'choco-test-vm'
$script:ChocoPackagesRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$script:WinRmPort = 55985
$script:GuestWinRmPort = 5985
$script:WinRmTarget = $null
$script:GuestTestAllPackagesScript = '& "$env:USERPROFILE/TestAllPackages.ps1"'

function Get-MyChTestVmName {
    if ($Env:au_TestVmName) { return $Env:au_TestVmName }
    return $script:DefaultVmName
}

function Get-MyChVagrantPath {
    param([string]$Vagrant)

    $path = if ($Vagrant) { $Vagrant } else { $Env:au_Vagrant }
    if (-not $path) {
        throw 'au_Vagrant is not set. Run init.ps1 in my-chocolatey-test-environment or set $Env:au_Vagrant.'
    }
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Vagrant path not found: $path"
    }
    return (Resolve-Path -LiteralPath $path).Path
}

function Get-MyChTestVm {
    $vmName = Get-MyChTestVmName
    $vm = Get-VM -Name $vmName -ErrorAction SilentlyContinue
    if (-not $vm) {
        throw "Hyper-V VM not found: $vmName. Run init.ps1 or check au_TestVmName."
    }
    return $vm
}

function Get-MyChTestVmSnapshot {
    param([string]$Snapshot)

    $vmName = Get-MyChTestVmName
    $name = if ($Snapshot) { $Snapshot } elseif ($Env:au_VmSnapshot) { $Env:au_VmSnapshot } else { $null }

    if ($name) {
        $snap = Get-VMSnapshot -VMName $vmName -Name $name -ErrorAction SilentlyContinue
        if (-not $snap) {
            throw "Checkpoint not found: '$name' on VM '$vmName'."
        }
        return $snap
    }

    $snaps = @(Get-VMSnapshot -VMName $vmName -ErrorAction SilentlyContinue | Sort-Object CreationTime -Descending)
    if ($snaps.Count -eq 0) {
        throw "No checkpoints found on VM '$vmName'. Create one with: Checkpoint-VM -VMName $vmName -Name good"
    }
    return $snaps[0]
}

function Resolve-MyChNupkg {
    param(
        $Nu
    )

    if (-not $Nu) {
        $dir = Get-Item -LiteralPath $PWD
    } else {
        if (-not (Test-Path -LiteralPath $Nu)) { throw "Path not found: $Nu" }
        $Nu = Get-Item -LiteralPath $Nu
        if ($Nu.PSIsContainer) {
            $dir = $Nu
            $Nu = $null
        } else {
            $dir = $Nu.Directory
        }
    }

    if (-not $Nu) {
        $Nu = Get-ChildItem -LiteralPath $dir.FullName -Filter '*.nupkg' -File |
            Sort-Object CreationTime -Descending |
            Select-Object -First 1
        if (-not $Nu) {
            $Nu = Get-ChildItem -LiteralPath $dir.FullName -Filter '*.nuspec' -File | Select-Object -First 1
        }
        if (-not $Nu) {
            throw @"
Can't find nupkg or nuspec file in the directory: $($dir.FullName)
Run from a package folder (e.g. automatic\<id>) or pass -Nu with a path to a .nupkg, .nuspec, or package directory.
"@
        }
    }

    if ($Nu.Extension -eq '.nuspec') {
        Write-Host 'Nuspec file given, running choco pack'
        & choco pack -r $Nu.FullName --OutputDirectory $Nu.DirectoryName
        if ($LASTEXITCODE -ne 0) { throw "choco pack failed with exit code $LASTEXITCODE" }
        $Nu = Get-ChildItem -LiteralPath $Nu.DirectoryName -Filter '*.nupkg' -File |
            Sort-Object CreationTime -Descending |
            Select-Object -First 1
        if (-not $Nu) { throw 'choco pack did not produce a nupkg file' }
    } elseif ($Nu.Extension -ne '.nupkg') {
        throw 'File is not nupkg or nuspec file'
    }

    return $Nu
}

function Test-MyChWinRmPortOpen {
    param(
        [string]$ComputerName = '127.0.0.1',
        [int]$Port = $script:WinRmPort
    )

    $client = $null
    try {
        $client = New-Object System.Net.Sockets.TcpClient
        $connect = $client.BeginConnect($ComputerName, $Port, $null, $null)
        if (-not $connect.AsyncWaitHandle.WaitOne(2000, $false)) {
            return $false
        }
        $client.EndConnect($connect)
        return $true
    } catch {
        return $false
    } finally {
        if ($client) { $client.Close() }
    }
}

function Get-MyChTestVmWinRmTargets {
    $targets = [System.Collections.Generic.List[hashtable]]::new()

    $vm = Get-MyChTestVm
    $ips = @(Get-VMNetworkAdapter -VM $vm -ErrorAction SilentlyContinue |
        ForEach-Object { $_.IPAddresses } |
        Where-Object { $_ -match '^(?:\d{1,3}\.){3}\d{1,3}$' -and $_ -notmatch '^169\.254\.' } |
        Select-Object -Unique)

    foreach ($ip in $ips) {
        $targets.Add(@{
            ComputerName = $ip
            Port         = $script:GuestWinRmPort
            Via          = 'hyperv'
        })
    }

    $targets.Add(@{
        ComputerName = '127.0.0.1'
        Port         = $script:WinRmPort
        Via          = 'forwarded'
    })

    return $targets
}

function Wait-MyChTestVmWinRm {
    param(
        [int]$TimeoutSeconds = 120,
        [int]$IntervalSeconds = 3
    )

    $script:WinRmTarget = $null
    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    Write-Host "Waiting for guest WinRM (up to ${TimeoutSeconds}s)..."

    while ((Get-Date) -lt $deadline) {
        $targets = @(Get-MyChTestVmWinRmTargets)
        if ($targets.Count -eq 0) {
            Write-Host '  no WinRM targets resolved yet'
        }

        foreach ($target in $targets) {
            Write-Host "  probing $($target.Via) $($target.ComputerName):$($target.Port)..."
            if (-not (Test-MyChWinRmPortOpen -ComputerName $target.ComputerName -Port $target.Port)) {
                continue
            }

            try {
                $secPassword = ConvertTo-SecureString 'vagrant' -AsPlainText -Force
                $credential = New-Object System.Management.Automation.PSCredential('vagrant', $secPassword)
                $sessionOption = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
                $session = New-PSSession `
                    -ComputerName $target.ComputerName `
                    -Port $target.Port `
                    -Credential $credential `
                    -SessionOption $sessionOption `
                    -ErrorAction Stop
                Remove-PSSession -Session $session -ErrorAction SilentlyContinue
                $script:WinRmTarget = $target
                Write-Host "WinRM is ready ($($target.Via): $($target.ComputerName):$($target.Port))."
                return
            } catch {
                Write-Host "  WinRM session failed: $($_.Exception.Message)"
            }
        }
        Start-Sleep -Seconds $IntervalSeconds
    }

    throw @"
Timed out waiting for guest WinRM after ${TimeoutSeconds}s.
Direct WinRM from the host often does not work with Hyper-V (firewall / no port forward).
Use Test-MyChPackageVm without -ShowOutput, or rely on vagrant powershell (-ShowOutput uses vagrant on Hyper-V).
"@
}

function Invoke-MyChTestVmScriptViaVagrant {
    param(
        [Parameter(Mandatory)]
        [string]$Script,
        [string]$Vagrant,
        [switch]$ShowOutput
    )

    $vagrantPath = Get-MyChVagrantPath -Vagrant $Vagrant
    $command = if ($ShowOutput) {
        @"
`$exitCode = 0
try {
    & { $Script; if (`$null -ne `$LASTEXITCODE) { `$exitCode = `$LASTEXITCODE } } *>&1 | ForEach-Object {
        if (`$_ -is [System.Management.Automation.ErrorRecord]) { `$_.ToString() } else { "`$_" }
    }
} catch {
    `$_.Exception.Message
    `$exitCode = 1
}
exit `$exitCode
"@
    } else {
        $Script
    }

    Push-Location $vagrantPath
    try {
        if ($ShowOutput) {
            & vagrant powershell -e -c $command | ForEach-Object { Write-Host $_ }
        } else {
            & vagrant powershell -e -c $command
        }
        if ($null -eq $LASTEXITCODE) { return 0 }
        return [int]$LASTEXITCODE
    } finally {
        Pop-Location
    }
}

function Start-MyChTestVm {
    $vm = Get-MyChTestVm
    if ($vm.State -eq 'Running') {
        Write-Host "VM '$($vm.Name)' is already running."
        return
    }

    Write-Host "Starting VM '$($vm.Name)'..."
    Start-VM -VM $vm | Out-Null

    $deadline = (Get-Date).AddMinutes(10)
    while ((Get-Date) -lt $deadline) {
        $vm = Get-MyChTestVm
        if ($vm.State -eq 'Running') {
            Write-Host "VM '$($vm.Name)' is running."
            return
        }
        Start-Sleep -Seconds 2
    }
    throw "Timed out waiting for VM '$($vm.Name)' to reach Running state."
}

function Stop-MyChTestVm {
    param(
        [switch]$TurnOff,
        [switch]$Save
    )

    if ($TurnOff -and $Save) {
        throw 'Cannot use -TurnOff and -Save together.'
    }

    $vm = Get-MyChTestVm
    if ($vm.State -eq 'Off') {
        Write-Host "VM '$($vm.Name)' is already off."
        return
    }

    if ($TurnOff) {
        Write-Host "Turning off VM '$($vm.Name)'..."
        Stop-VM -VM $vm -TurnOff -Force | Out-Null
    } elseif ($Save) {
        Write-Host "Saving VM '$($vm.Name)'..."
        Stop-VM -VM $vm -Save | Out-Null
    } else {
        Write-Host "Shutting down VM '$($vm.Name)'..."
        Stop-VM -VM $vm | Out-Null
    }

    Write-Host "VM '$($vm.Name)' stopped."
}

function Connect-MyChTestVm {
    $vmName = Get-MyChTestVmName
    $existing = Get-Process -Name vmconnect -ErrorAction SilentlyContinue
    if ($existing) {
        Write-Verbose 'vmconnect process already running; opening another window.'
    }
    Start-Process -FilePath 'vmconnect.exe' -ArgumentList 'localhost', $vmName
}

function Restore-MyChTestVm {
    param([string]$Snapshot)

    $vmName = Get-MyChTestVmName
    $snap = Get-MyChTestVmSnapshot -Snapshot $Snapshot
    Write-Host "Restoring checkpoint '$($snap.Name)' on VM '$vmName'..."
    Restore-VMSnapshot -VMSnapshot $snap -Confirm:$false | Out-Null
    Write-Host 'Checkpoint restored.'
}

function Stage-MyChTestPackage {
    param(
        $Nu,
        [switch]$NoClear,
        [string]$Vagrant
    )

    $vagrantPath = Get-MyChVagrantPath -Vagrant $Vagrant
    $Nu = Resolve-MyChNupkg -Nu $Nu

    $packageName = $Nu.Name -replace '(\.\d+)+(-[^-]+)?\.nupkg$'
    $packageVersion = ($Nu.BaseName -replace [regex]::Escape($packageName)).Substring(1)

    Write-Host ''
    Write-Host 'Package info'
    Write-Host ('  Path:'.PadRight(15)) $Nu.FullName
    Write-Host ('  Name:'.PadRight(15)) $packageName
    Write-Host ('  Version:'.PadRight(15)) $packageVersion
    Write-Host ('  Vagrant:'.PadRight(15)) $vagrantPath

    $packagesDir = Join-Path $vagrantPath 'packages'
    if (-not (Test-Path -LiteralPath $packagesDir)) {
        throw "Packages directory not found: $packagesDir"
    }

    if (-not $NoClear) {
        Write-Host 'Removing existing vagrant packages'
        Remove-Item (Join-Path $packagesDir '*.nupkg') -Force -ErrorAction SilentlyContinue
        Remove-Item (Join-Path $packagesDir '*.xml') -Force -ErrorAction SilentlyContinue
    }

    Copy-Item -LiteralPath $Nu.FullName -Destination $packagesDir -Force
    Write-Host "Copied to $packagesDir"
}

function Invoke-MyChTestVmWinRm {
    param(
        [Parameter(Mandatory)]
        [string]$Script,
        [switch]$ShowOutput
    )

    Wait-MyChTestVmWinRm

    if (-not $script:WinRmTarget) {
        throw 'WinRM target was not resolved.'
    }

    $target = $script:WinRmTarget
    $secPassword = ConvertTo-SecureString 'vagrant' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential('vagrant', $secPassword)
    $sessionOption = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck

    $session = $null
    try {
        $session = New-PSSession `
            -ComputerName $target.ComputerName `
            -Port $target.Port `
            -Credential $credential `
            -SessionOption $sessionOption `
            -ErrorAction Stop

        if ($ShowOutput) {
            $items = Invoke-Command -Session $session -ScriptBlock {
                param($Command)
                $exitCode = 0
                & {
                    Invoke-Expression $Command
                    $exitCode = $LASTEXITCODE
                } 2>&1 | ForEach-Object {
                    if ($_ -is [System.Management.Automation.ErrorRecord]) {
                        $_.ToString()
                    } else {
                        "$_"
                    }
                }
                [PSCustomObject]@{ __MyChExitCode = $exitCode }
            } -ArgumentList $Script

            $exitCode = 1
            foreach ($item in $items) {
                if ($item -is [PSCustomObject] -and $null -ne $item.PSObject.Properties['__MyChExitCode']) {
                    $exitCode = $item.__MyChExitCode
                } elseif ($null -ne $item -and "$item" -ne '') {
                    Write-Host $item
                }
            }
            return $exitCode
        }

        $result = Invoke-Command -Session $session -ScriptBlock {
            param($Command)
            Invoke-Expression $Command
            [PSCustomObject]@{ __MyChExitCode = $LASTEXITCODE }
        } -ArgumentList $Script

        if ($null -eq $result.__MyChExitCode) { return 0 }
        return $result.__MyChExitCode
    } finally {
        if ($session) {
            Remove-PSSession -Session $session -ErrorAction SilentlyContinue
        }
    }
}

function Invoke-MyChTestVmScript {
    param(
        [Parameter(Mandatory)]
        [string]$Script,
        [string]$Vagrant,
        [switch]$ShowOutput
    )

    if ($ShowOutput) {
        # Hyper-V: vagrant reaches WinRM reliably; direct host WinRM often never connects.
        return Invoke-MyChTestVmScriptViaVagrant -Script $Script -Vagrant $Vagrant -ShowOutput
    }

    $exitCode = Invoke-MyChTestVmScriptViaVagrant -Script $Script -Vagrant $Vagrant
    if ($exitCode -eq 0) {
        return $exitCode
    }

    Write-Warning "vagrant powershell exited with $exitCode; trying direct WinRM..."
    try {
        return Invoke-MyChTestVmWinRm -Script $Script
    } catch {
        throw "Guest command failed via vagrant and WinRM fallback: $_"
    }
}

function Start-MyChTestPackageManual {
    param(
        $Nu,
        [switch]$NoClear,
        [string]$Snapshot,
        [switch]$NoConnect,
        [string]$Vagrant
    )

    Stage-MyChTestPackage -Nu $Nu -NoClear:$NoClear -Vagrant $Vagrant
    Restore-MyChTestVm -Snapshot $Snapshot
    Start-MyChTestVm
    if (-not $NoConnect) {
        Connect-MyChTestVm
    }

    Write-Host ''
    Write-Host 'Package staged. In the guest, run:' -ForegroundColor Cyan
    Write-Host '  ~\TestAllPackages.ps1'
    Write-Host '  ~\TestAllPackages.ps1 -UninstallAfterInstall'
}

function Test-MyChPackageVm {
    param(
        $Nu,
        [switch]$UninstallAfterInstall,
        [switch]$ShowOutput,
        [string]$Snapshot,
        [string]$Vagrant
    )

    $exitCode = 1
    $snap = Get-MyChTestVmSnapshot -Snapshot $Snapshot
    $snapName = $snap.Name
    $restoredForTest = $false

    try {
        Stage-MyChTestPackage -Nu $Nu -Vagrant $Vagrant
        Restore-MyChTestVm -Snapshot $snapName
        $restoredForTest = $true
        Start-MyChTestVm

        $remote = $script:GuestTestAllPackagesScript
        if ($UninstallAfterInstall) {
            $remote = '& "$env:USERPROFILE/TestAllPackages.ps1" -UninstallAfterInstall'
        }

        $exitCode = Invoke-MyChTestVmScript -Script $remote -Vagrant $Vagrant -ShowOutput:$ShowOutput
        if ($null -eq $exitCode) { $exitCode = 0 }
        $exitCode = [int]$exitCode
    } finally {
        if ($restoredForTest) {
            Restore-MyChTestVm -Snapshot $snapName
        }
    }

    if ($exitCode -ne 0) {
        Write-Host "Test failed with exit code $exitCode" -ForegroundColor Red
    } else {
        Write-Host 'Test passed.' -ForegroundColor Green
    }

    return $exitCode
}

function Clear-MyChPackageArtifacts {
    param([string]$RepoRoot)

    $root = if ($RepoRoot) {
        (Resolve-Path -LiteralPath $RepoRoot).Path
    } else {
        $script:ChocoPackagesRoot
    }

    $folderPaths = @(
        (Join-Path $root 'automatic'),
        (Join-Path $root 'manual')
    )

    foreach ($folderPath in $folderPaths) {
        if (-not (Test-Path -LiteralPath $folderPath)) { continue }

        Get-ChildItem -LiteralPath $folderPath -Recurse -File -Filter '*.nupkg' | ForEach-Object {
            try {
                Remove-Item -LiteralPath $_.FullName -Force
                Write-Host "Deleted file: $($_.FullName)"
            } catch {
                Write-Warning "Failed to delete file: $($_.FullName). Error: $_"
            }
        }
    }
}

function Start-MyChTestPackageCleanUp {
    param(
        $Nu,
        [switch]$NoClear,
        [string]$Snapshot,
        [switch]$NoConnect,
        [string]$Vagrant
    )

    Clear-MyChPackageArtifacts
    Start-MyChTestPackageManual -Nu $Nu -NoClear:$NoClear -Snapshot $Snapshot -NoConnect:$NoConnect -Vagrant $Vagrant
}

function Stop-MyChTestVmCleanUp {
    param(
        [switch]$TurnOff,
        [switch]$Save,
        [string]$RepoRoot
    )

    Stop-MyChTestVm -TurnOff:$TurnOff -Save:$Save
    Clear-MyChPackageArtifacts -RepoRoot $RepoRoot
}

Export-ModuleMember -Function @(
    'Start-MyChTestVm',
    'Stop-MyChTestVm',
    'Connect-MyChTestVm',
    'Restore-MyChTestVm',
    'Stage-MyChTestPackage',
    'Start-MyChTestPackageManual',
    'Test-MyChPackageVm',
    'Clear-MyChPackageArtifacts',
    'Start-MyChTestPackageCleanUp',
    'Stop-MyChTestVmCleanUp'
)
