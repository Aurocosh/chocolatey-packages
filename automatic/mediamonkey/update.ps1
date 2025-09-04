Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.mediamonkey.com/download'

    $regex = "MediaMonkey-\d+_Setup.exe"
    $Url32 = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
    
    $regex = "MediaMonkey_(\d+\.\d+\.\d+\.\d+)\."
    $RedirectedUrl32 = Get-RedirectedUrl -URL $Url32
    $RedirectedUrl32 -match $regex | Out-Null
    
    $version = $matches[1]
	
    @{
        URL32   = $RedirectedUrl32
        Version = $version
    }
}


update -ChecksumFor 32
