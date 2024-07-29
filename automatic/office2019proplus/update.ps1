import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $releases = 'https://www.microsoft.com/en-us/download/details.aspx?id=49117'
    $download_page = Invoke-WebRequest -Uri $releases
    $urlRegex = "officedeploymenttool_\d+-\d+.exe"
    $remoteUrl = $download_page.links | Where-Object href -match $urlRegex | Select-Object -First 1 -expand href

    $installScriptPath = "$PSScriptRoot/tools/chocolateyinstall.ps1"
    (Get-Content -Path $installScriptPath -Raw) -Match "url\s*=\s*'([^']*)'"
    $url = $matches[1]

    $nuspecFile = "$PSScriptRoot/office2019proplus.nuspec"
    (Get-Content -Path $nuspecFile -Raw) -Match '<version>((\d+\.\d+).*)<\/version>'
    $version = $matches[1]
    $baseVersion = $matches[2]

    if ($remoteUrl -and ($remoteUrl -ne $localUrl)) {
        $url = $remoteUrl
        $dateString = (Get-Date).ToString("yyyyMMdd")
        $version = "$baseVersion.0.$dateString"
    }

    @{
        URL32   = $url
        Version = $version
    }
}

update -ChecksumFor 32