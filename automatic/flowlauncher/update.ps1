Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
            "(?i)(\<dependency id=`"flow-launcher`" version=`"\[).*?(\]`" /\>)" = "`${1}$($Latest.Version)`$2"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser Flow-Launcher `
        -RepoName Flow.Launcher `
        -MainUrl64Regex "Flow-Launcher-Setup\.exe" `
        -Buffered 60
    @{
        Version      = $release.Version
        ReleaseNotes = $release.ReleaseUrl
    }
}

update -ChecksumFor none
