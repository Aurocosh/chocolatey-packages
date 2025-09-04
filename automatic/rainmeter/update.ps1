Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

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
        -GitUser rainmeter `
        -RepoName rainmeter `
        -MainUrl64Regex "Rainmeter-\d+\.\d+\.\d+.exe"

    # Truncate revision from version string
    $release.Version -Match "(\d+\.\d+\.\d+)\.\d+"
    $version = $matches[1]

    @{
        URL64   = $release.MainUrl64
        Version = $version
    }
}

update -ChecksumFor 64
