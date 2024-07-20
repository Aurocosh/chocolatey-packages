import-module au

$releases = 'https://inputdirector.com/downloads.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re = "InputDirector\.v(\d+\.\d+(?:\.\d+)?)\.zip"
    $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
	
    if ($url -match $re) {
        $version = $matches[1]
    }
	
    $url = 'https://inputdirector.com/' + $url

    @{
        URL     = $url
        Version = $version
    }
}

update -ChecksumFor 32 -NoCheckUrl