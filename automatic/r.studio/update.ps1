Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
        }
        "$($Latest.PackageName).nuspec" = @{
          "(?i)(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://docs.posit.co/ide/user/' -UseBasicParsing

    # Open Source Windows installer only (exclude Pro builds like RStudio-pro-...)
    $regex64 = 'https://download1\.rstudio\.org/electron/windows/RStudio-(\d+\.\d+\.\d+)-\d+\.exe'
    $url64 = $download_page.Links | Where-Object href -match $regex64 | Select-Object -First 1 -ExpandProperty href
    if (-not ($url64 -match $regex64)) {
        throw 'Unable to find RStudio Windows download URL on docs.posit.co'
    }
    $version = $matches[1]
    $releaseNotesUrl = "https://docs.posit.co/ide/news/#rstudio-$version"

    @{
        URL64         = $url64
        Version       = $version
        ReleaseNotes  = $releaseNotesUrl
    }
}

update -ChecksumFor 64
