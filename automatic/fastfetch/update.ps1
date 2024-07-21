import-module au

$releases = 'https://api.github.com/repos/xgi/houdoku/releases/latest'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_assets = (Invoke-WebRequest $releases | ConvertFrom-Json).assets

    $specific_asset = $download_assets | Where-Object name -like "fastfetch-windows-i686.zip"
    $url = $specific_asset.browser_download_url
	
    $specific_asset = $download_assets | Where-Object name -like "fastfetch-windows-amd64.zip"
    $url64 = $specific_asset.browser_download_url
	
    if ($url64 -match "download/(\d+\.\d+\.\d+)/fastfetch-windows-amd64.zip") {
        $version = $matches[1]
    }
	
    @{
        URL     = $url
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor 32 64