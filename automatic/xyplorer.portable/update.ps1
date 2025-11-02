Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.Url)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $releases = 'https://www.xyplorer.com/freezer.php'
    $response = Invoke-WebRequest -Uri $releases

    foreach ($link in $response.links | Where-Object href -match "\?ver=((\d+\.\d+)\.\d+)" | Select-Object -expand href) {
        $fullLink = "https://www.xyplorer.com/freezer.php$link"
        Write-Host "link $fullLink"
        $subResponse = Invoke-WebRequest -Uri $fullLink

        $downloadPortableUrl = $subResponse.links | Where-Object href -match "xyplorer(64)?_full_noinstall.zip" | Select-Object -First 1 -expand href
        if (-not $downloadPortableUrl) {
            throw "Download portable url was not found"
        }
        $downloadPortableUrl = "https://www.xyplorer.com/$downloadPortableUrl"

        $bit64MarkerPortable = $matches[1]

        if ($bit64MarkerPortable -eq '64') {
            continue;
        }

        $checksumUrl = $subResponse.links | Where-Object href -match "download/XYHash(?:64)?-((\d+\.\d+)\.\d+).txt" | Select-Object -First 1 -expand href
        if (-not $checksumUrl) {
            throw 'Checksum url was not found'
        }
        $checksumUrl = "https://www.xyplorer.com/$checksumUrl"
        
        $version = $matches[1]
        $majorVersion = $matches[2]
        Write-Host $version
        Write-Host $majorVersion

        $releaseNotesUrl = $subResponse.links | Where-Object href -match "release_[\d\.]+.php" | Select-Object -First 1 -expand href
        if (-not $checksumUrl) {
            throw 'Checksum url was not found'
        }
        $releaseNotesUrl = "https://www.xyplorer.com/$releaseNotesUrl"
        
        $checksumResponse = Invoke-WebRequest -Uri $checksumUrl

        $checksumResponse.Content -match "(?s)File: xyplorer(?:64)?_full_noinstall.zip.*?SHA-256\s*([a-fA-F0-9]{64})"
        $checksumPortable = $matches[1]

        break;
    }

    @{
        Url        = $downloadPortableUrl
        Checksum   = $checksumPortable
        Version      = $version
        ReleaseNotes = $releaseNotesUrl
    }
}

update -ChecksumFor none