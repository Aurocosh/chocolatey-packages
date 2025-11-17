Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
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
        $link -match "\?ver=((\d+\.\d+)\.\d+)"
        $version = $matches[1]
        $majorVersion = $matches[2]

        $fullLink = "https://www.xyplorer.com/freezer.php$link"
        Write-Host "link $fullLink"
        $subResponse = Invoke-WebRequest -Uri $fullLink

        $downloadFullUrl = $subResponse.links | Where-Object href -match "xyplorer(64)?_full.zip" | Select-Object -First 1 -expand href
        if (-not $downloadFullUrl) {
            throw 'Download full url was not found'
        }
        $downloadFullUrl = "https://www.xyplorer.com/$downloadFullUrl"

        $bit64MarkerFull = $matches[1]
        if ($bit64MarkerFull -eq '64') {
            continue;
        }

        Write-Host $version
        Write-Host $majorVersion

        $releaseNotesUrl = $subResponse.links | Where-Object href -match "release_[\d\.]+.php" | Select-Object -First 1 -expand href
        if (-not $releaseNotesUrl) {
            throw 'Release url was not found'
        }
        $releaseNotesUrl = "https://www.xyplorer.com/$releaseNotesUrl"

        break;
    }

    @{
        Url32        = $downloadFullUrl
        Version      = $version
        ReleaseNotes = $releaseNotesUrl
    }
}

update -ChecksumFor 32