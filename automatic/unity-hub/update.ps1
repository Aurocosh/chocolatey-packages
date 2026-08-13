Import-Module Chocolatey-AU

$latestYmlUrl = 'https://public-cdn.cloud.unity3d.com/hub/prod/latest.yml'
$downloadBaseUrl = 'https://public-cdn.cloud.unity3d.com/hub/prod/'

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]url64\s*=\s*)(.*)" = "`$1""$($Latest.URL64)"""
            "(?i)(^\s*[$]checksum64\s*=\s*)(.*)" = "`$1""$($Latest.Checksum64)"""
        }
    }
}

function global:au_GetLatest {
    $yml = [System.Text.Encoding]::UTF8.GetString(
        (Invoke-WebRequest -Uri $latestYmlUrl -UseBasicParsing).Content
    )

    $version = [regex]::Match($yml, '(?m)^version:\s*(\S+)').Groups[1].Value
    $path = [regex]::Match($yml, '(?m)^path:\s*(\S+)').Groups[1].Value

    if (-not $version -or -not $path) {
        throw "Could not parse Unity Hub latest.yml from $latestYmlUrl"
    }

    @{
        Version = $version
        URL64   = "$downloadBaseUrl$path"
    }
}

update -ChecksumFor 64
