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
    Get-GithubRepoInfo -User 'librespeed' -Repo 'speedtest-cli'

    @{
        URL32 = $($links -match 'windows_386').browser_download_url
        URL64 = $($links -match 'windows_amd64').browser_download_url
        Version = $tag -replace 'v'
    }
}

. $(Join-Path -Path "$(Split-Path -parent $PSScriptRoot)" -ChildPath 'update_common.ps1')
