Import-Module Chocolatey-AU

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
    $releases = 'https://regedix.webrox.fr'
    $download_page = Invoke-WebRequest -Uri $releases

    $url32Regex = "(download\.php.*Regedix-(\d+\.\d+\.\d+)-x86.exe)"
    if ($download_page.content -match $url32Regex) {
        $url32 = "https://regedix.webrox.fr/" + $matches[1]
        $version = $matches[2]
    }

    $url64Regex = "(download\.php.*Regedix-(\d+\.\d+\.\d+)-x64.exe)"
    if ($download_page.content -match $url64Regex) {
        $url64 = "https://regedix.webrox.fr/" + $matches[1]
    }
    
    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor all

Remove-Item -Path "$PSScriptRoot/Regedix.exe" -Force -ErrorAction SilentlyContinue