import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://antibody-software.com/wizfile/download'

    $regex64 = "wizfile_(\d+_\d+)_setup.exe"
    $url64 = $download_page.links | Where-Object href -match $regex64 | Select-Object -First 1 -expand href
    $version = $matches[1] -replace "_", "."

    @{
        URL64   = "https://antibody-software.com" + $url64
        Version = $version
    }
}

update -ChecksumFor 64