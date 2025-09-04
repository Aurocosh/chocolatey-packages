Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser azahar-emu `
    -RepoName azahar `
    -MainUrl64Regex "azahar-\d+(?:\.\d+)?(-rc\d+)?-windows-msvc.zip"

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
        Version     = '0.' + $release.Version
    }
}

update -ChecksumFor $release.ChocoChecksumFor
