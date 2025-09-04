Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
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
    $response = Invoke-WebRequest -Uri "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/p/Proton/ProtonAuthenticator" -Method Get
    $jsonValue = ConvertFrom-Json $response.Content
    $version = $jsonValue[-1].name

    $manifestUrl = "https://raw.githubusercontent.com/microsoft/winget-pkgs/master/manifests/p/Proton/ProtonAuthenticator/$version/Proton.ProtonAuthenticator.installer.yaml"
    $response = Invoke-WebRequest -Uri $manifestUrl

    $response.Content -match "InstallerUrl:\s*(https://proton.me/download/authenticator/[^\s]*\.msi)"
    $url64 = $matches[1]

    $response.Content -match "InstallerSha256:\s*([a-fA-F0-9]{64})"
    $sha256 =  $matches[1].toLower()
	
    @{
        URL64   = $url64
        Version = $version
        Checksum64 = $sha256
    }
}

# NoCheckUrl because we cannot validate the url. The site is blocked on the AppVeyor update server 
update -ChecksumFor none -NoCheckUrl
