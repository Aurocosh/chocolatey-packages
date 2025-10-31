Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser rainmeter `
    -RepoName rainmeter `
    -MainUrl64Regex "Rainmeter-\d+\.\d+\.\d+.exe"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    # Truncate revision from version string
    $release.Version -Match "(\d+\.\d+\.\d+)\.\d+"
    $version = $matches[1]

    @{
        Url64        = $release.MainUrl64
        Checksum64   = $release.MainUrl64_Sha256
        Version      = $version
        ReleaseNotes = $release.ReleaseUrl
    }
}

update -ChecksumFor $release.ChocoChecksumFor
