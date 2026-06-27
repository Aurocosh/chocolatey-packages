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

function Invoke-MyChTestVmScript {
    param(
        [Parameter(Mandatory)]
        [string]$Script,
        [string]$Vagrant,
        [switch]$ShowOutput
    )

    if ($ShowOutput) {
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
