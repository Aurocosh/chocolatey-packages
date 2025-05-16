import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $releases = 'https://inputdirector.com/downloads.html'
    $download_page = Invoke-WebRequest -Uri $releases

    $re = "InputDirector\.v(\d+\.\d+(?:\.\d+)?)\.zip"
    $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
    $version = $matches[1]
    
    if ($url) {
        $url = 'https://inputdirector.com/' + $url
    }

    @{
        URL32   = $url
        Version = $version
        Options = @{
            Headers = @{"User-Agent" = "Chocolatey AU update check. https://chocolatey.org"}
        }
    }
}

update -ChecksumFor 32