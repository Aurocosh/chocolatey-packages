import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.snipaste.com/download.html'

    $versionRegex = "<h4><b>v(\d+\.\d+\.\d+)<\/b>"
    if ($download_page.content -match $versionRegex) {
        $version = $matches[1]
    }

    $re32 = "\/\/dl.snipaste.com\/win-x64(-beta)?"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href
    
    $re64 = "\/\/dl.snipaste.com\/win-x64(-beta)?"
    $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href
    
    $isBeta = $matches[1]
    if ($version -and $isBeta) {
        $version += "-Beta"
    }
    
    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor all