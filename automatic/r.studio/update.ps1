import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://posit.co/download/rstudio-desktop/'

    $regex64 = "RStudio-(\d+\.\d+\.\d+)-\d+\.exe"
    $url64 = $download_page.links | Where-Object href -match $regex64 | Select-Object -First 1 -expand href
    $version = $matches[1]
	
    @{
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor 64
