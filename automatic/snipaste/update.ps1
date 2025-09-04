Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $url64 = Get-RedirectedUrl -URL "https://dl.snipaste.com/win-x64"

    $versionRegex = ".*Snipaste-(\d+.\d+(?:\.\d+)?)-x64.zip"
    if ($url64 -match $versionRegex) {
	    $version = $matches[1]
    }

    @{
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor 64