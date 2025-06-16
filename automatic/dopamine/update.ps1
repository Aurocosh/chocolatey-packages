import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{}
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser digimezzo `
        -RepoName dopamine-windows `
        -MainUrl32Regex "Dopamine.\d+\.\d+\.\d+.Release.msi" `
        -VersionRegex "^v(\d+\.\d+\.\d+)\.\d+$"
    @{
        Version = $release.Version
    }
}

update -ChecksumFor none

