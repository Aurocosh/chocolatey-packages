Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.glasswire.com/changes'

    $regex32 = 'glasswire-setup-(\d+\.\d+\.\d+)-full\.exe'
    $url32 = $download_page.links | Where-Object href -match $regex32 | Select-Object -First 1 -expand href

    $version = $matches[1]

    @{
        Url32   = $url32
        Version = $version
    }
}

update -ChecksumFor all