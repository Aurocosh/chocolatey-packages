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
    $releases = 'https://regedix.webrox.fr/'
    $download_page = Invoke-WebRequest -Uri $releases

    $url32Regex = "Regedix-(\d+\.\d+\.\d+)-x86.exe"
    $url32 = $download_page.links | Where-Object href -match $url32Regex | Select-Object -First 1 -expand href

    $url64Regex = "Regedix-(\d+\.\d+\.\d+)-x64.exe"
    $url64 = $download_page.links | Where-Object href -match $url64Regex | Select-Object -First 1 -expand href

    $version = $matches[1]
    
    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor all
