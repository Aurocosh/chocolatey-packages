import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    $checksumMSVC = Get-RemoteChecksum $Latest.URL_MSVC
    $checksumGNU = Get-RemoteChecksum $Latest.URL_GNU

    Write-Host "Checksum MSVC: $checksumMSVC"
    Write-Host "Checksum GNU: $checksumGNU"
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url64msvc\s*=\s*)('.*')"      = "`$1'$($Latest.URL_MSVC)'"
            "(?i)(checksum64msvc\s*=\s*)('.*')" = "`$1'$checksumMSVC'"
            "(?i)(url64gnu\s*=\s*)('.*')"       = "`$1'$($Latest.URL_GNU)'"
            "(?i)(checksum64gnu\s*=\s*)('.*')"  = "`$1'$checksumGNU'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser fujiapple852 `
        -RepoName trippy `
        -MainUrl32Regex "trippy-\d+.\d+.\d+-x86_64-pc-windows-msvc.zip" `
        -MainUrl64Regex "trippy-\d+.\d+.\d+-x86_64-pc-windows-gnu.zip"
    @{
        URL_MSVC = $release.MainUrl32
        URL_GNU  = $release.MainUrl64
        Version  = $release.Version
    }
}

update -ChecksumFor none