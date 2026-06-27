function Get-MyChSanitizedVagrantOutput {
    param([string]$Line)

    if ($null -eq $Line) { return $null }

    # Vagrant meta lines (command echo, success banner) — not guest stdout
    if ($Line -match '^\s*==>') { return $null }

    # Strip repeated machine prefixes, e.g. "    default: message" or nested "default: default: ..."
    $content = $Line
    $previous = $null
    while ($content -ne $previous -and $content -match '^\s*\S+:\s?(.*)$') {
        $previous = $content
        $content = $Matches[1]
    }

    # Trailing machine prefix fragments from merged vagrant lines
    $content = $content -replace '(\s+\S+:\s*)+$', ''

    if ($content -match '^\s*$') { return $null }

    return $content
}

function Write-MyChVagrantOutputLine {
    param([string]$Line)

    $text = Get-MyChSanitizedVagrantOutput -Line $Line
    if ($null -ne $text) {
        Write-Host $text
    }
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
            & vagrant powershell -e -c $command 2>&1 | ForEach-Object {
                $line = if ($_ -is [System.Management.Automation.ErrorRecord]) { $_.ToString() } else { "$_" }
                Write-MyChVagrantOutputLine -Line $line
            }
        } else {
            $prevEap = $ErrorActionPreference
            $ErrorActionPreference = 'Continue'
            try {
                $null = & vagrant powershell -e -c $command 2>&1
            } finally {
                $ErrorActionPreference = $prevEap
            }
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
