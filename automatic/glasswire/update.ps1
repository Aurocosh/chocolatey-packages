Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(?i)(^\s*\$packageArgs\.url64bit\s*=\s*)(''.*'')'   = "`$1'$($Latest.Url64)'"
            '(?i)(^\s*\$packageArgs\.checksum64\s*=\s*)(''.*'')' = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.glasswire.com/' -UseBasicParsing -UserAgent $userAgent
    $regex64 = 'https://download\.glasswire\.com/latest/GlassWireSetup\.exe\?v=(\d+\.\d+\.\d+)'

    if ($download_page.Content -notmatch $regex64) {
        throw 'Could not find GlassWire download URL on https://www.glasswire.com/'
    }

    @{
        Url64   = [string]$matches[0]
        Version = [string]$matches[1]
        Options = @{
            Headers = @{
                'User-Agent' = $userAgent
            }
        }
    }
}

update -ChecksumFor 64
