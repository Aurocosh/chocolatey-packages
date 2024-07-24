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
    
    @{
        URL32   = 'https://dl.snipaste.com/win-x86-beta'
        URL64   = 'https://dl.snipaste.com/win-x64-beta'
        Version = $version
    }
}

update -ChecksumFor all