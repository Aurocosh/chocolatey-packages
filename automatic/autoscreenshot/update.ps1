import-module au

$releases = 'https://api.github.com/repos/artem78/AutoScreenshot/releases/latest'
$re = "AutoScreenshot_v(\d+\.\d+(?:\.\d+)?)_Windows_setup.exe"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $download_assets = (Invoke-WebRequest $releases | ConvertFrom-Json).assets
    $specific_asset = $download_assets | Where-Object name -match $re
    $url = $specific_asset.browser_download_url
	
    if ($url -match $re) {
        $version = $matches[1]
    }
	
    @{
        URL     = $url
        Version = $version
    }
}

update -ChecksumFor 32