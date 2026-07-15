Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser PixiEditor `
    -RepoName PixiEditor `
    -MainUrl64Regex "PixiEditor-\d+\.\d+\.\d+\.\d+-setup-x64-win.exe"

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
          "(?i)(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
          "(?i)(\<dependency id=`"pixieditor.install`" version=`"\[).*?(\]`" /\>)" = "`${1}$($Latest.Version)`$2"
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
