import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $response = Invoke-WebRequest -Uri "https://proton.me/download/authenticator/windows/version.json" -Method Get
    $jsonValue = ConvertFrom-Json $response.Content
	
    @{
        URL64   = $jsonValue.Releases[0].File.Url
        Version = $jsonValue.Releases[0].Version
    }
}

update -ChecksumFor 64
