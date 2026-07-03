Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        "$($Latest.PackageName).nuspec" = @{
          "(?i)(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $versionXmlUrl = 'https://raw.githubusercontent.com/Ross-Patterson/Portals-Desktop-Organization/main/current-version.xml'
    $response = Invoke-WebRequestRetry -Uri $versionXmlUrl -UseBasicParsing
    [xml]$doc = $response.Content
    $item = $doc.item

    @{
        Url64        = [string]$item.url
        Version      = [string]$item.version
        ReleaseNotes = [string]$item.changelog
    }
}

update -ChecksumFor 64
