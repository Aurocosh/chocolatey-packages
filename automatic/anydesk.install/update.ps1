Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$changelogUrl = 'https://download.anydesk.com/changelog.txt'
$url32        = 'https://download.anydesk.com/AnyDesk.exe'

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            "(?i)(^\s*[$]url32\s*=\s*)('.*')"       = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $changelog = (Invoke-WebRequestRetry -Uri $changelogUrl -UseBasicParsing -Buffered 60).Content
    $match = [regex]::Match($changelog, '(?m)^\d{2}\.\d{2}\.\d{4} - (\d+\.\d+\.\d+) \(Windows\)')

    if (-not $match.Success) {
        throw "Could not find Windows version in $changelogUrl"
    }

    @{
        Version = $match.Groups[1].Value
        URL32   = $url32
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor 32
}
