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
    $releases = 'https://codeproject.github.io'
    $download_page = Invoke-WebRequest -Uri $releases

    $urlRegex = "CodeProject.AI-Server_(\d+\.\d+\.\d+)_win_x64.zip"
    $url64 = $download_page.links | Where-Object href -match $urlRegex | Select-Object -First 1 -expand href
    $version = $matches[1]
    
    @{
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor 64

$archiveFile = (Get-ChildItem $PSScriptRoot -filter "CodeProject.AI-Server_*_win_x64.zip" -File | Select-Object -First 1).FullName
if($archiveFile) {
    Remove-Item -Path $archiveFile -Force -ErrorAction SilentlyContinue
}