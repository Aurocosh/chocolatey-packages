import-module au

$NoCheckChocoVersion = 'true'
$url = 'https://www.mediamonkey.com/MediaMonkey-5_Setup'
$forumsticky = "https://www.mediamonkey.com/forum/viewtopic.php?f=3&t=8811"


function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $forumsticky
    
    $content = $download_page.tostring() -split "[`r`n]" | select-string "MediaMonkey: 5." | Select-Object -First 1
    [regex]$regex = '[0-9][0-9]?[.][0-9][0-9]?[.][0-9][0-9]?[.][0-9][0-9][0-9][0-9]?'
    $versiontemp = $regex.Matches($content) |ForEach-Object {$_.Value}
    $version = $versiontemp[0]
	
    @{
        URL32   = $url + ".exe"
        Version = $version
    }
}


update
