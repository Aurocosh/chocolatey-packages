Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.xdlab.ru/en/download.htm'

    $regex32 = "tagscan-(\d+\.\d+\.\d+)\.zip"
    $url32 = $download_page.links | Where-Object href -match $regex32 | Select-Object -First 1 -expand href

    $regex64 = "tagscan-(\d+\.\d+\.\d+)_x64\.zip"
    $url64 = $download_page.links | Where-Object href -match $regex64 | Select-Object -First 1 -expand href

    $version = $matches[1]
    $baseUrl = 'https://www.xdlab.ru'

    @{
        Url32   = $baseUrl + $url32
        Url64   = $baseUrl + $url64
        Version = $version
    }
}

update -ChecksumFor all
