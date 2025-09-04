Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

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
        -RepoName VCEEnc `
        -MainUrl32Regex "VCEEncC_\d+\.\d+_Win32.7z" `
        -MainUrl64Regex "VCEEncC_\d+\.\d+_x64.7z"
    @{
        URL32   = $release.MainUrl32
        URL64   = $release.MainUrl64
        Version = $release.Version
    }
}

update -ChecksumFor all
