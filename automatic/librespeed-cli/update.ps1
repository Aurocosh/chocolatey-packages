Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser librespeed `
    -RepoName speedtest-cli `
    -MainUrl32Regex "librespeed-cli_\d+\.\d+\.\d+_windows_386.zip" `
    -MainUrl64Regex "librespeed-cli_\d+\.\d+\.\d+_windows_amd64.zip"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"   = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    @{
        Url32        = $release.MainUrl32
        Checksum32   = $release.MainUrl32_Sha256
        Url64        = $release.MainUrl64
        Checksum64   = $release.MainUrl64_Sha256
        Version      = $release.Version
        ReleaseNotes = $release.ReleaseUrl
    }
}

update -ChecksumFor $release.ChocoChecksumFor

