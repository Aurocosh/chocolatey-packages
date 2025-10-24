Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
          "(?i)(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
		
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $response = Invoke-WebRequest -Uri 'https://gitea.com/api/v1/repos/gitea/tea/releases/latest' -Method Get
    $jsonValue = ConvertFrom-Json $response.Content

    $regex64 = "tea-(\d+\.\d+\.\d+)-windows-amd64\.exe"
    $url64 = $jsonValue.assets | Where-Object browser_download_url -match $regex64 | Select-Object -First 1 -expand browser_download_url
    $version = $matches[1]
	
    @{
        Url64   = $url64
        Version = $version
        ReleaseNotes = $jsonValue.html_url
    }
}

update -ChecksumFor 64