Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser theryangeary `
    -RepoName choose `
    -MainUrl64Regex "choose-x86_64-pc-windows-gnu.exe"

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
          "(?i)(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
		
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    @{
        Url64        = $release.MainUrl64
        Checksum64   = $release.MainUrl64_Sha256
        Version      = $release.Version
        ReleaseNotes = $release.ReleaseUrl
    }
}

update -ChecksumFor $release.ChocoChecksumFor

