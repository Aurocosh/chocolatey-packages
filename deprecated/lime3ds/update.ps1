Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    $checksumMSVC = Get-RemoteChecksum $Latest.URL_MSVC
    $checksumMSYS2 = Get-RemoteChecksum $Latest.URL_MSYS2

    Write-Host "Checksum MSVC: $checksumMSVC"
    Write-Host "Checksum MSYS2: $checksumMSYS2"
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url64msvc\s*=\s*)('.*')"       = "`$1'$($Latest.URL_MSVC)'"
            "(?i)(checksum64msvc\s*=\s*)('.*')"  = "`$1'$checksumMSVC'"
            "(?i)(url64msys2\s*=\s*)('.*')"      = "`$1'$($Latest.URL_MSYS2)'"
            "(?i)(checksum64msys2\s*=\s*)('.*')" = "`$1'$checksumMSYS2'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser Lime3DS `
        -RepoName Lime3DS `
        -MainUrl32Regex "lime3ds-\d+(?:\.\d+)?-windows-msvc-installer.exe" `
        -MainUrl64Regex "lime3ds-\d+(?:\.\d+)?-windows-msys2-installer.exe"
    @{
        URL_MSVC  = $release.MainUrl32
        URL_MSYS2 = $release.MainUrl64
        Version   = '0.' + $release.Version
    }
}

update -ChecksumFor none