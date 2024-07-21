import-module au

$releases = 'https://api.github.com/repos/MatsuriDayo/nekoray/releases/latest'
$re = "nekoray-(\d+\.\d+)-\d+-\d+-\d+-windows64.zip"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_assets = (Invoke-WebRequest $releases | ConvertFrom-Json).assets
    $specific_asset = $download_assets | Where-Object name -match $re
    $url64 = $specific_asset.browser_download_url
	
    if ($url64 -match $re) {
        $version = $matches[1]
    }
	
    @{
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor 64