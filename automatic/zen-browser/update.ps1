import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    $checksumGeneric = Get-RemoteChecksum $Latest.URL_GENERIC
    $checksumOptimized = Get-RemoteChecksum $Latest.URL_OPTIMIZED

    Write-Host "Checksum Generic: $checksumGeneric"
    Write-Host "Checksum Optimized: $checksumOptimized"
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(urlGeneric64\s*=\s*)('.*')"        = "`$1'$($Latest.URL_GENERIC)'"
            "(?i)(checksumGeneric64\s*=\s*)('.*')"   = "`$1'$checksumGeneric'"
            "(?i)(urlOptimized64\s*=\s*)('.*')"      = "`$1'$($Latest.URL_OPTIMIZED)'"
            "(?i)(checksumOptimized64\s*=\s*)('.*')" = "`$1'$checksumOptimized'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser zen-browser `
        -RepoName desktop `
        -MainUrl32Regex "zen.installer-generic.exe" `
        -MainUrl64Regex "zen.installer.exe"
    @{
        URL_GENERIC   = $release.MainUrl32
        URL_OPTIMIZED = $release.MainUrl64
        Version       = $release.Version
    }
}

update -ChecksumFor none
