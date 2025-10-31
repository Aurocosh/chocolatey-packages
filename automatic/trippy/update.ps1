Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser fujiapple852 `
    -RepoName trippy `
    -MainUrl32Regex "trippy-\d+\.\d+\.\d+-x86_64-pc-windows-msvc\.zip" `
    -MainUrl64Regex "trippy-\d+\.\d+\.\d+-x86_64-pc-windows-gnu\.zip"

function global:au_SearchReplace {
    $checksumMSVC = $Latest.Checksum_MSVC
    if (-not $checksumMSVC){
        $checksumMSVC = Get-RemoteChecksum $Latest.URL_MSVC
    }
    
    $checksumGNU = $Latest.Checksum_GNU
    if (-not $checksumGNU){
        $checksumGNU = Get-RemoteChecksum $Latest.URL_GNU
    }

    Write-Host "Checksum MSVC: $checksumMSVC"
    Write-Host "Checksum GNU: $checksumGNU"
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url64msvc\s*=\s*)('.*')"      = "`$1'$($Latest.URL_MSVC)'"
            "(?i)(checksum64msvc\s*=\s*)('.*')" = "`$1'$checksumMSVC'"
            "(?i)(url64gnu\s*=\s*)('.*')"       = "`$1'$($Latest.URL_GNU)'"
            "(?i)(checksum64gnu\s*=\s*)('.*')"  = "`$1'$checksumGNU'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    @{
        URL_MSVC        = $release.MainUrl32
        Checksum_MSVC   = $release.MainUrl32_Sha256
        URL_GNU         = $release.MainUrl64
        Checksum_GNU    = $release.MainUrl64_Sha256
        Version         = $release.Version
        ReleaseNotes    = $release.ReleaseUrl
    }
}

update -ChecksumFor none