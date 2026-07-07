Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(?i)(^\s*\$packageArgs\.url64bit\s*=\s*)(''.*'')'   = "`$1'$($Latest.Url64)'"
            '(?i)(^\s*\$packageArgs\.checksum64\s*=\s*)(''.*'')' = "`$1'$($Latest.Checksum64)'"
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
    Get-LatestWingetPkgsRelease `
        -ManifestPath 'g/GlassWire/GlassWire' `
        -InstallerManifest 'GlassWire.GlassWire.installer.yaml' `
        -InstallerUrlRegex 'InstallerUrl:\s*(https://.*?.exe)' `
        -VersionRegex '^\d+(?:\.\d+){1,2}$'
}

update -ChecksumFor none -NoCheckUrl
