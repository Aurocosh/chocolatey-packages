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
    $download_page = Invoke-WebRequest -Uri 'https://www.cdisplayex.com/desktop/'

    $regex32 = "CDXWin32v(\d+\.\d+\.\d+)\.exe"
    $url32 = $download_page.links | Where-Object href -match $regex32 | Select-Object -First 1 -expand href

    $regex64 = "CDXWin64v(\d+\.\d+\.\d+)\.exe"
    $url64 = $download_page.links | Where-Object href -match $regex64 | Select-Object -First 1 -expand href

    $version = $matches[1]
    $baseUrl = 'https://www.cdisplayex.com'

    @{
        Url32   = $baseUrl + $url32
        Url64   = $baseUrl + $url64
        Version = $version
    }
}

update -ChecksumFor all