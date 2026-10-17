Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser Murmele `
    -RepoName Gittyup `
    -MainUrl32Regex "Gittyup-win32-\d+\.\d+\.\d+\.exe" `
    -MainUrl64Regex "Gittyup-win64-\d+\.\d+\.\d+\.exe"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    # Latest release may not include Windows installers — treat as unchanged.
    if (-not $release.MainUrl32 -or -not $release.MainUrl64) {
        return @{ Version = (Get-NuspecMetadata -key version) }
    }

    @{
        Url32        = $release.MainUrl32
        Checksum32   = $release.MainUrl32_Sha256
        Url64        = $release.MainUrl64
        Checksum64   = $release.MainUrl64_Sha256
        Version      = $release.Version
        ReleaseNotes = $release.ReleaseUrl
    }
}

if (-not $release.MainUrl32 -or -not $release.MainUrl64) {
    # Avoid Chocolatey fix notation from forced updates when nothing changed.
    $global:au_Force = $false
    update -ChecksumFor none
} else {
    update -ChecksumFor $release.ChocoChecksumFor
}
