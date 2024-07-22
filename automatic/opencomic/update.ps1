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
        -GitUser ollm `
        -RepoName OpenComic `
        -MainUrl64Regex "OpenComic.Setup.\d+.\d+.\d+.exe"
    @{
        URL64   = $release.MainUrl64
        Version = $release.Version
    }
}

update -ChecksumFor 64