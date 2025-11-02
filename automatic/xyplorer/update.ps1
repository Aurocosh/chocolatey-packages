Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.Url)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    foreach ($link in $response.links | Where-Object href -match "\?ver=((\d+\.\d+)\.\d+)" | Select-Object -expand href) {
        $fullLink = "https://www.xyplorer.com/freezer.php$link"
        Write-Host "link $fullLink"
        $subResponse = Invoke-WebRequest -Uri $fullLink
        if ($subResponse.Content -match "XYplorer ((\d+\.\d+)\.\d+) \(32-bit\)") {
            $version = $matches[1]
            $majorVersion = $matches[2]
            Write-Host $version
            Write-Host $majorVersion

            $checksumUrl = $subResponse.links | Where-Object href -match "download/XYHash(?:64)?-[\d\.]+.txt" | Select-Object -First 1 -expand href
            if (-not $checksumUrl) {
                throw "Checksum url was not found"
            }
            $checksumUrl = "https://www.xyplorer.com/$checksumUrl"

            $releaseNotesUrl = $subResponse.links | Where-Object href -match "release_[\d\.]+.php" | Select-Object -First 1 -expand href
            if (-not $checksumUrl) {
                throw "Checksum url was not found"
            }
            $releaseNotesUrl = "https://www.xyplorer.com/$releaseNotesUrl"
            
            $downloadFullUrl = $subResponse.links | Where-Object href -match "xyplorer(?:64)?_full.zip" | Select-Object -First 1 -expand href
            if (-not $downloadFullUrl) {
                throw "Download full url was not found"
            }
            $downloadFullUrl = "https://www.xyplorer.com/$downloadFullUrl"

            $checksumResponse = Invoke-WebRequest -Uri $checksumUrl

            $checksumResponse.Content -match "(?s)File: xyplorer(?:64)?_full.zip.*?SHA-256\s*([a-fA-F0-9]{64})"
            $checksumFull = $matches[1]

            break;
        }
    }

    @{
        Url          = $downloadFullUrl
        Checksum     = $checksumFull
        Version      = $version
        ReleaseNotes = $releaseNotesUrl
    }
}

update -ChecksumFor none