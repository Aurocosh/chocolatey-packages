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
        -GitUser azahar-emu `
        -RepoName azahar `
        -MainUrl64Regex "azahar-\d+(?:\.\d+)?(-rc\d+)?-windows-msvc-installer.exe"
    @{
        URL64   = $release.MainUrl64
        Version = "0." + $release.Version
    }
}

update -ChecksumFor 64

