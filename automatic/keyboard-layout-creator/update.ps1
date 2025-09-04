Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.microsoft.com/en-us/download/details.aspx?id=102134'
    $urlPattern = "*MSKLC.exe"
    $remoteUrl = $download_page.links | Where-Object href -like $urlPattern | Select-Object -First 1 -expand href

    $installScriptPath = "$PSScriptRoot/tools/chocolateyinstall.ps1"
    (Get-Content -Path $installScriptPath -Raw) -Match "url\s*=\s*'([^']*)'"
    $url = $matches[1]

    $nuspecFile = "$PSScriptRoot/keyboard-layout-creator.nuspec"
    (Get-Content -Path $nuspecFile -Raw) -Match '<version>((\d+\.\d+).*)<\/version>'
    $version = $matches[1]
    $baseVersion = $matches[2]

    if ($remoteUrl -and ($remoteUrl -ne $url)) {
        $url = $remoteUrl
        $dateString = (Get-Date).ToString("yyyyMMdd")
        $version = "$baseVersion.0.$dateString"
    }

    @{
        Url32   = $url
        Version = $version
    }
}

update -ChecksumFor 32
