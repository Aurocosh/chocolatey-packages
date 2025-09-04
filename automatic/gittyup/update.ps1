Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser Murmele `
    -RepoName Gittyup `
    -MainUrl32Regex "Gittyup-win32-\d+\.\d+\.\d+\.exe" `
    -MainUrl64Regex "Gittyup-win64-\d+\.\d+\.\d+\.exe"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    @{
        Url32       = $release.MainUrl32
        Checksum32  = $release.MainUrl32_Sha256
        Url64       = $release.MainUrl64
        Checksum64  = $release.MainUrl64_Sha256
        Version     = $release.Version
    }
}

update -ChecksumFor $release.ChocoChecksumFor
