import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser artem78 `
        -RepoName AutoScreenshot `
        -MainUrl32Regex "AutoScreenshot_v\d+.\d+_Windows_portable.zip"
    @{
        URL     = $release.MainUrl32
        Version = $release.Version
    }
}

update -ChecksumFor 64