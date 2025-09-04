Import-Module Chocolatey-AU

$downloadApi = 'https://api.audiorelay.net/downloads'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $response = Invoke-WebRequest -Uri $downloadApi -Method Get
    $jsonValue = ConvertFrom-Json $response.Content
	
    @{
        URL64   = $jsonValue.windows.downloadUrl
        Version = $jsonValue.windows.version
    }
}

update -ChecksumFor 64