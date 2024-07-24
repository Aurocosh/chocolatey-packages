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
    $release = Get-LatestGithubRelease `
        -GitUser lycheeverse `
        -RepoName lychee `
        -MainUrl64Regex "lychee-v\d+\.\d+\.\d+-windows-x86_64\.exe"
    @{
        URL64   = $release.MainUrl64
        Version = $release.Version
    }
}

update -ChecksumFor 64