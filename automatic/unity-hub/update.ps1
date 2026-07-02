Import-Module Chocolatey-AU

$releaseNotesUrl = 'https://unity.com/unity-hub/release-notes'
$url64 = 'https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup-x64.exe'

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]url64\s*=\s*)(.*)" = "`$1""$($Latest.URL64)"""
            "(?i)(^\s*[$]checksum64\s*=\s*)(.*)" = "`$1""$($Latest.Checksum64)"""
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releaseNotesUrl -UseBasicParsing

    $version = [regex]::Match(
        $page.Content,
        'whitespace-nowrap[^>]*>(\d+\.\d+\.\d+)<'
    ).Groups[1].Value

    if (-not $version) {
        $version = [regex]::Match(
            $page.Content,
            'mango-text-heading-xl[^>]*>(\d+\.\d+\.\d+)</h2>'
        ).Groups[1].Value
    }

    if (-not $version) {
        throw "Could not find Unity Hub version on $releaseNotesUrl"
    }

    @{
        Version = $version
        URL64   = $url64
    }
}

update -ChecksumFor 64
