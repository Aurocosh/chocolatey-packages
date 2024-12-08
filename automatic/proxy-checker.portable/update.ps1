import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://vovsoft.com/software/proxy-checker'

    $versionRegex = "<b>Version:</b>\s*(\d+.\d+(?:.\d+)?)\s\("
    if ($download_page.content -match $versionRegex) {
        $version = $matches[1]
        $url32 = "https://files.vovsoft.com/proxy-checker-portable.zip?v=$version"
    }
	
    @{
        URL32   = $url32
        Version = $version
    }
}

update -ChecksumFor 32