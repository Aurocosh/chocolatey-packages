#Requires -Version 5.1

$script:DefaultVmName = 'choco-test-vm'
$script:ChocoPackagesRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$script:WinRmPort = 55985

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
        if (-not $Nu) { throw "Can't find nupkg or nuspec file in the directory: $($dir.FullName)" }
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

function Invoke-MyChTestVmScript {
    param(
        [Parameter(Mandatory)]
        [string]$Script,
        [string]$Vagrant
    )

    $vagrantPath = Get-MyChVagrantPath -Vagrant $Vagrant

    Push-Location $vagrantPath
    try {
        & vagrant powershell -e -c $Script
        $exitCode = $LASTEXITCODE
        if ($exitCode -eq 0 -or $null -eq $exitCode) {
            return $exitCode
        }
        Write-Warning "vagrant powershell exited with $exitCode; trying direct WinRM..."
    } finally {
        Pop-Location
    }

    $secPassword = ConvertTo-SecureString 'vagrant' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential('vagrant', $secPassword)
    $sessionOption = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck

    $session = $null
    try {
        $session = New-PSSession `
            -ComputerName 'localhost' `
            -Port $script:WinRmPort `
            -UseSSL `
            -Credential $credential `
            -SessionOption $sessionOption `
            -ErrorAction Stop

        Invoke-Command -Session $session -ScriptBlock {
            param($Command)
            Invoke-Expression $Command
            exit $LASTEXITCODE
        } -ArgumentList $Script
        return $LASTEXITCODE
    } catch {
        throw "Guest command failed via vagrant and WinRM fallback: $_"
    } finally {
        if ($session) {
            Remove-PSSession -Session $session -ErrorAction SilentlyContinue
        }
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
        [string]$Snapshot,
        [string]$Vagrant
    )

    $exitCode = 1
    $snap = Get-MyChTestVmSnapshot -Snapshot $Snapshot
    $snapName = $snap.Name

    try {
        Restore-MyChTestVm -Snapshot $snapName
        Start-MyChTestVm
        Stage-MyChTestPackage -Nu $Nu -Vagrant $Vagrant

        $remote = "& '$HOME\TestAllPackages.ps1'"
        if ($UninstallAfterInstall) {
            $remote = "& '$HOME/TestAllPackages.ps1' -UninstallAfterInstall"
        }

        Invoke-MyChTestVmScript -Script $remote -Vagrant $Vagrant
        $exitCode = $LASTEXITCODE
        if ($null -eq $exitCode) { $exitCode = 0 }
    } finally {
        Restore-MyChTestVm -Snapshot $snapName
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
