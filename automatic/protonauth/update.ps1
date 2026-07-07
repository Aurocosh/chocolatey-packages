Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
        }
    }
}

# Version update directly from the original site does not work on the AppVeyor build server. Site "https://proton.me" seems to be blocked
# function global:au_GetLatest {
#     $response = Invoke-WebRequest -Uri "https://proton.me/download/authenticator/windows/version.json" -Method Get
#     $jsonValue = ConvertFrom-Json $response.Content

#     @{
#         URL64   = $jsonValue.Releases[0].File.Url
#         Version = $jsonValue.Releases[0].Version
#     }
# }

# update -ChecksumFor 64

# Update will piggyback from the winget repo until better solution is found

function global:au_GetLatest {
    Get-LatestWingetPkgsRelease `
        -ManifestPath 'p/Proton/ProtonAuthenticator' `
        -InstallerManifest 'Proton.ProtonAuthenticator.installer.yaml' `
        -InstallerUrlRegex 'InstallerUrl:\s*(https://proton.me/download/authenticator/[^\s]*\.msi)'
}

# NoCheckUrl because we cannot validate the url. The site is blocked on the AppVeyor update server 
update -ChecksumFor none -NoCheckUrl
