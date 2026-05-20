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
    $releaseUrl = "https://www.xyplorer.com/download.php?bit=32"
    $response = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing

    $response.Content -match "<td class=`"dl`">(\d+\.\d+)\.(\d+) \(32-bit, \d+-\w+-\d+\)</td>"
    $majorVersion = $matches[1]
    $buildVersion = $matches[2]
    $version = "$majorVersion.$buildVersion"

    $downloadUrl = "https://www.xyplorer.com/free-zer/$majorVersion/xyplorer_full.zip"
    $releaseNotesUrl = "https://www.xyplorer.com/release_$majorVersion.php"

    # Start-Sleep -Seconds 5
    # $hashUrl = "https://www.xyplorer.com/download/XYHash-$version.txt"
    # $response = Invoke-WebRequest -Uri $hashUrl

    # $response.Content -match "File: xyplorer_full.zip.+SHA-256\s+([a-fA-F0-9]{64})"
    # $sha256 = $matches[1]

    @{
        Url32        = $downloadUrl
        Version      = $version
        ReleaseNotes = $releaseNotesUrl
        # Checksum32   = $sha256
    }
}

update -ChecksumFor 32