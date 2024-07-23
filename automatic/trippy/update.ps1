import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

# This package does not actually have 32 and 64 bit versions. Those are MSVC and GNU variants.

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url64msvc\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(?i)(checksum64msvc\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"

            "(?i)(url64gnu\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"
            "(?i)(checksum64gnu\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser emuell `
        -RepoName restic-browser `
        -MainUrl32Regex "trippy-\d+.\d+.\d+-x86_64-pc-windows-msvc.zip" `
        -MainUrl64Regex "trippy-\d+.\d+.\d+-x86_64-pc-windows-gnu.zip"
    @{
        URL32   = $release.MainUrl32
        URL64   = $release.MainUrl64
        Version = $release.Version
    }
}

update -ChecksumFor 32 64