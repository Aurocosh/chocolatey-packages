import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$releases = 'http://www.winsetupfromusb.com/downloads/'

function global:au_SearchReplace {
    # Find download link on the download info page
    $infoPage = Invoke-WebRequest -Uri $Latest.INFO_URL
    $re = "http://www.winsetupfromusb.com/download/winsetupfromusb-\d+\-\d+-exe/"
    $downloadUrl = $infoPage.links | Where-Object href -match $re | Select-Object -First 1 -expand href

    # Resolve indirect download url and extract downloaded file name
    $directUrl = Get-RedirectedUrl $downloadUrl
    $fileName = $directUrl.Split('/')[-1]

    # Download zip file with program
    $installerFile = "$PSScriptRoot/tools/$fileName"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerFile -Headers @{ Referer = $releases }

    # Calculate various checksums for VERIFICATION.txt
    $sha1 = (Get-FileHash $installerFile -Algorithm SHA1).Hash
    $md5 = (Get-FileHash $installerFile -Algorithm MD5).Hash

    # Calculate checksum for installation script
    $sha256 = (Get-FileHash $installerFile -Algorithm SHA256).Hash

    # Generate new VERIFICATION.txt for new version from template
    $verificationTemplate = "$PSScriptRoot/template/VERIFICATION.txt"
    $verificationTarget = "$PSScriptRoot/tools/VERIFICATION.txt"

    $markers = @{
        infoUrl = $Latest.INFO_URL
        sha1 = $sha1
        md5 = $md5
    }
    Set-ReplaceMarkersInFile $verificationTemplate $verificationTarget $markers

    # Print all data
    Write-Host "Info URL: $infoUrl"
    Write-Host "Download URL: $downloadUrl"
    Write-Host "Direct URL: $directUrl"
    Write-Host "fileName: $fileName"
    Write-Host "Checksum sha1: $sha1"
    Write-Host "Checksum sha256: $sha256"
    Write-Host "Checksum md5: $md5"

    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($sha256)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    # Find url with specific download information for the latest version
    $re = "http://www.winsetupfromusb.com/files/download-info/winsetupfromusb-(\d+\-\d+)-exe/"
    $infoUrl = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
    $version = ($matches[1] -replace "-", ".")

    @{
        INFO_URL  = $infoUrl
        Version   = $version
    }
}

update -ChecksumFor none