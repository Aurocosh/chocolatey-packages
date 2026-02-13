Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

# function global:au_GetLatest {
#     $download_page = Invoke-WebRequest -Uri 'https://www.glasswire.com/changes' -UseBasicParsing

#     $regex32 = 'glasswire-setup-(\d+\.\d+\.\d+)-full\.exe'
#     $url32 = $download_page.links | Where-Object href -match $regex32 | Select-Object -First 1 -expand href

#     $version = $matches[1]

#     @{
#         Url32   = $url32
#         Version = $version
#     }
# }

function global:au_GetLatest {
    $response = Invoke-WebRequest -Uri "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/g/GlassWire/GlassWire" -Method Get -UseBasicParsing
    $jsonValue = ConvertFrom-Json $response.Content

    for ($ia = $jsonValue.length; $ia -gt -1; $ia--) {
        $version = $jsonValue[$ia].name
        if($version -match "^\d+(?:\.\d+){1,2}$")
        {
            break
        }
    }

    $manifestUrl = "https://raw.githubusercontent.com/microsoft/winget-pkgs/master/manifests/g/GlassWire/GlassWire/$version/GlassWire.GlassWire.installer.yaml"
    $response = Invoke-WebRequest -Uri $manifestUrl -UseBasicParsing

    $response.Content -match "InstallerUrl:\s*(https://download.glasswire.com/f/[^\s]*\.exe)"
    $url32 = $matches[1]

    $response.Content -match "InstallerSha256:\s*([a-fA-F0-9]{64})"
    $sha256 =  $matches[1].toLower()
	
    @{
        URL32   = $url32
        Version = $version
        Checksum32 = $sha256
    }
}

update -ChecksumFor none -NoCheckUrl