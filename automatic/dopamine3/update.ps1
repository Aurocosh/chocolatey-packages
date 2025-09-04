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
        -GitUser digimezzo `
        -RepoName dopamine `
        -MainUrl64Regex "Dopamine-\d+\.\d+\.\d+-preview.\d+.exe" `
        -VersionRegex "(\d+(?:\.\d+){0,3})\-?([a-z]+\.?(?:[0-9]+)?)?(?:-.+)?$" `
        -UsePreRelease
    @{
        URL64   = $release.MainUrl64
        Version = $release.Version
    }
}

update -ChecksumFor 64

