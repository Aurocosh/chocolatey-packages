Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser digimezzo `
        -RepoName dopamine-windows `
        -MainUrl32Regex "Dopamine.\d+\.\d+\.\d+.Release.msi" `
        -VersionRegex "^v(\d+\.\d+\.\d+)\.\d+$"
    @{
        URL32   = $release.MainUrl32
        Version = $release.Version
    }
}

update -ChecksumFor 32

