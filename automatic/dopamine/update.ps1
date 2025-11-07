Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
            "(?i)(\<dependency id=`"dopamine[23]`" version=`"\[).*?(\]`" /\>)" = "`${1}$($Latest.Version)`$2"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser digimezzo `
        -RepoName dopamine `
        -MainUrl64Regex "Dopamine-\d+\.\d+\.\d+.exe"
    @{
        Version      = $release.Version
        ReleaseNotes = $release.ReleaseUrl
    }
}

update -ChecksumFor none

