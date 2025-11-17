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

        $downloadPortableUrl = $subResponse.links | Where-Object href -match "xyplorer(64)?_full_noinstall.zip" | Select-Object -First 1 -expand href
        if (-not $downloadPortableUrl) {
            throw "Download portable url was not found"
        }
        $downloadPortableUrl = "https://www.xyplorer.com/$downloadPortableUrl"

        $bit64MarkerPortable = $matches[1]
        if ($bit64MarkerPortable -eq '64') {
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
        Url32        = $downloadPortableUrl
        Version      = $version
        ReleaseNotes = $releaseNotesUrl
    }
}

update -ChecksumFor 32