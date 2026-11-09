Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser cdgriffith `
    -RepoName FastFlix `
    -MainUrl64Regex "FastFlix_\d+\.\d+\.\d+_win64\.zip" `
    -Buffered 60

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(?i)(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
            "(?i)(\<dependency id=`"fastflix.portable`" version=`"\[).*?(\]`" /\>)" = "`${1}$($Latest.Version)`$2"
        }
    }
}

function global:au_GetLatest {
    @{
        Version      = $release.Version
        ReleaseNotes = $release.ReleaseUrl
    }
}

update -ChecksumFor none
