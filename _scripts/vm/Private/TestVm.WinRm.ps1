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
