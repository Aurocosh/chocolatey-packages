. $(Join-Path -Path "$(Split-Path -parent $PSScriptRoot)" -ChildPath 'common.ps1')

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    Get-GithubRepoInfo -User 'stnkl' -Repo 'EverythingToolbar'

    @{
        URL64 = $($links -match '.msi').browser_download_url
        Version = $tag
    }
}

. $(Join-Path -Path "$(Split-Path -parent $PSScriptRoot)" -ChildPath 'update_common.ps1')
