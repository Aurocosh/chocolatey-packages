import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser rigaya `
        -RepoName NVEnc `
        -MainUrl32Regex "NVEncC_\d+\.\d+_Win32.7z" `
        -MainUrl64Regex "NVEncC_\d+\.\d+_x64.7z" `
        -VersionRegex "^(\d+(?:\.\d+){0,3})$"
    @{
        URL32   = $release.MainUrl32
        URL64   = $release.MainUrl64
        Version = $release.Version
    }
}

update -ChecksumFor all
