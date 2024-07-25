import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $releases = 'https://www.codeproject.com/Articles/5322557/CodeProject-AI-Server-AI-the-easy-way'
    $download_page = Invoke-WebRequest -Uri $releases

    $urlRegex = "CodeProject.AI-Server-win-x64-(\d+\.\d+\.\d+)\.zip"
    $url64 = $download_page.links | Where-Object href -match $urlRegex | Select-Object -First 1 -expand href
    $version = $matches[1]
    
    if ($url64) {
        $url64 = 'https://www.codeproject.com/KB/Articles/5322557' + $url64
    }

    @{
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor 64

Remove-Item -Path "$PSScriptRoot/CodeProject.AI.zip" -Force