Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function Get-AnydeskWingetRelease {
    Get-LatestWingetPkgsRelease `
        -ManifestPath 'a/AnyDesk/AnyDesk' `
        -InstallerManifest 'AnyDesk.AnyDesk.installer.yaml' `
        -InstallerUrlRegex 'InstallerUrl:\s*(https://\S+)' `
        -VersionRegex '^\d+(?:\.\d+){1,2}$'
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            "(?i)(^\s*[$]url32\s*=\s*)('.*')"       = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-AnydeskWingetRelease

    if (-not $release.Version) {
        throw 'Could not find AnyDesk release in winget-pkgs'
    }

    @{
        Version    = $release.Version
        Url32      = $release.Url64
        Checksum32 = $release.Checksum64
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none -NoCheckUrl
}
