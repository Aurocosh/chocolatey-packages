Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser amir1376 `
    -RepoName ab-download-manager `
    -MainUrl64Regex "ABDownloadManager_\d+\.\d+\.\d+_windows_x64.exe"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    @{
        Url64       = $release.MainUrl64
        Checksum64  = $release.MainUrl64_Sha256
        Version     = $release.Version
    }
}

update -ChecksumFor $release.ChocoChecksumFor
