import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

# This package does not actually have 32 and 64 bit versions. Those are MSVC and GNU variants.

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url64msvc\s*=\s*)('.*')"      = "`$1'$($Latest.URL_MSVC)'"
            "(?i)(checksum64msvc\s*=\s*)('.*')" = "`$1'$($Latest.CHECKSUM_MSVC)'"

            "(?i)(url64gnu\s*=\s*)('.*')"       = "`$1'$($Latest.URL_GNU)'"
            "(?i)(checksum64gnu\s*=\s*)('.*')"  = "`$1'$($Latest.CHECKSUM_GNU)'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser fujiapple852 `
        -RepoName trippy `
        -MainUrl32Regex "trippy-\d+.\d+.\d+-x86_64-pc-windows-msvc.zip" `
        -MainUrl64Regex "trippy-\d+.\d+.\d+-x86_64-pc-windows-gnu.zip"

    @{
        URL_MSVC      = $release.MainUrl32
        CHECKSUM_MSVC = (Get-RemoteChecksum $release.MainUrl32)
        URL_GNU       = $release.MainUrl64
        CHECKSUM_GNU  = (Get-RemoteChecksum $release.MainUrl64)
        Version       = $release.Version
    }
}

update -ChecksumFor none