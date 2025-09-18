. $(Join-Path -Path "$(Split-Path -parent $PSScriptRoot)" -ChildPath 'common.ps1')

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $domain="https://www.xdlab.ru"
    $download_page = Invoke-WebRequest -Uri "$domain/download.htm" -UseBasicParsing
    $links = $download_page.links | ? href -match 'tagscan.*\.zip$' | select -First 2 -expand href;
    $version  = $links -notmatch 'x64'  -split '-' -replace '.zip' | Select -Last 1

    @{
        URL32 = "$domain$($links -notmatch 'x64')"
        URL64 = "$domain$($links -match 'x64')"
        Version = $version
    }
}

. $(Join-Path -Path "$(Split-Path -parent $PSScriptRoot)" -ChildPath 'update_common.ps1')
