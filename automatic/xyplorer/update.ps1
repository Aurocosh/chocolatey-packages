Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $releases = 'https://www.xyplorer.com/freezer.php'
    $download_page = Invoke-WebRequest -Uri $releases
    
    $re = "\?ver=((\d+\.\d+)\.\d+)"
    $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
    $version = $matches[1]
    $majorVersion = $matches[2]
    
    if ($majorVersion) {
        $url = "https://www.xyplorer.com/free-zer/$majorVersion/xyplorer_full.zip"
    }

    @{
        Url32   = $url
        Version = $version
    }
}

update -ChecksumFor 32