import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    $checksumRegular = Get-RemoteChecksum $Latest.URL_REGULAR
    $checksumLegacy = Get-RemoteChecksum $Latest.URL_LEGACY

    Write-Host "Checksum Regular: $checksumRegular"
    Write-Host "Checksum Legacy: $checksumLegacy"
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(urlRegular64\s*=\s*)('.*')"      = "`$1'$($Latest.URL_REGULAR)'"
            "(?i)(checksumRegular64\s*=\s*)('.*')" = "`$1'$checksumRegular'"
            "(?i)(urlLegacy64\s*=\s*)('.*')"       = "`$1'$($Latest.URL_LEGACY)'"
            "(?i)(checksumLegacy64\s*=\s*)('.*')"  = "`$1'$checksumLegacy'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser ozwaldorf `
        -RepoName lutgen-rs `
        -MainUrl32Regex "lutgen-\d+\.\d+\.\d+-x86_64-windows.zip" `
        -MainUrl64Regex "lutgen-\d+\.\d+\.\d+-x86_64-legacy-windows.zip"
    @{
        URL_REGULAR = $release.MainUrl32
        URL_LEGACY  = $release.MainUrl64
        Version     = $release.Version
    }
}

update -ChecksumFor none
