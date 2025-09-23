Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
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
        $url64 = "https://www.xyplorer.com/free-zer/$majorVersion/xyplorer64_full.zip"

        $checksumUrl = "https://www.xyplorer.com/download/XYHash64-$version.txt"
        $response = Invoke-WebRequest -Uri $checksumUrl

        $response.Content -match "(?s)File: xyplorer64_full.zip.*?SHA-256\s*?([a-fA-F0-9]{64})"
        $checksum64 = $matches[1]
    }

    @{
        Url64   = $url64
        Checksum64  = $checksum64
        Version = $version
    }
}

update -ChecksumFor none