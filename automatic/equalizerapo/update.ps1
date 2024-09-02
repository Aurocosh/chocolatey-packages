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
    $releases = 'https://sourceforge.net/projects/equalizerapo'
    $download_page = Invoke-WebRequest -Uri $releases
    
    $re = "https:\/\/sourceforge.net\/projects\/equalizerapo\/files\/(\d+\.\d+(?:\.\d+)?)\/"
    $download_page.links | Where-Object href -match $re | Out-Null
    $version = $matches[1]
    Write-Host $version
    
    if ($version) {
        $url32 = "https://sourceforge.net/projects/equalizerapo/files/$version/EqualizerAPO32-$version.exe/download"
        $url64 = "https://sourceforge.net/projects/equalizerapo/files/$version/EqualizerAPO64-$version.exe/download"
    }

    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor all