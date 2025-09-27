Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

function global:au_SearchReplace {
    $exeArchiveUrl = "https://mark0.net/download/trid_net.zip"
    $defsArchiveUrl = "https://mark0.net/download/triddefs_xml.7z"

    # Package file paths
    $exeArchiveFile = "$PSScriptRoot/tools/trid_net.zip"
    $defsArchiveFile = "$PSScriptRoot/tools/triddefs_xml.7z"

    $exePath = "$PSScriptRoot/tools/TrIDNet.exe"
    $targetFile = "$PSScriptRoot/tools/TrIDDefList.TRS"
    $licenseFile = "$PSScriptRoot/tools/LICENSE.txt"
    $verificationFile = "$PSScriptRoot/tools/VERIFICATION.txt"

    $definitionsDirectory = "$PSScriptRoot/tools/defs"
    $originalLicenseFile = "$PSScriptRoot/tools/readme_tridnet.txt"
    $verificationTemplateFile = "$PSScriptRoot/template/VERIFICATION.txt"

    # Cleaning up files from the previous updates if they exist
    Remove-Item $exeArchiveFile -Force -ErrorAction SilentlyContinue
    Remove-Item $defsArchiveFile -Force -ErrorAction SilentlyContinue

    Remove-Item $exePath -Force -ErrorAction SilentlyContinue
    Remove-Item $targetFile -Force -ErrorAction SilentlyContinue
    Remove-Item $licenseFile -Force -ErrorAction SilentlyContinue
    Remove-Item $verificationFile -Force -ErrorAction SilentlyContinue
    
    Remove-Item $originalLicenseFile -Force -ErrorAction SilentlyContinue
    Remove-Item $definitionsDirectory -Recurse -Force -ErrorAction SilentlyContinue

    # Downloading and unpacking exe and defs archives
    Invoke-WebRequest $exeArchiveUrl -OutFile $exeArchiveFile
    Invoke-WebRequest $defsArchiveUrl -OutFile $defsArchiveFile

    7z x $exeArchiveFile -o"$PSScriptRoot/tools" -y > $null
    7z x $defsArchiveFile -o"$PSScriptRoot/tools" -y > $null

    # Generating definitions database from XML definitions. To do so just launching the program. It will generate definitions automatically on launch
    $process = Start-Process -FilePath $exePath -PassThru

    # Waiting for the database file to be generated
    while (-not (Test-Path $targetFile)) {
        Start-Sleep -Seconds 1
    }

    # After the database file appeared we will wait a bit longer to make sure that we are not interrupting the data write process to the database file
    Start-Sleep -Seconds 10

    # Closing the TrIDNet process. It is no longer necessary
    Stop-Process -Id $process.Id -Force

    # Calculating the archive checksums for the VERIFICATION.txt
    $exeChecksum = (Get-FileHash $exeArchiveFile -Algorithm SHA256).Hash
    $defsChecksum = (Get-FileHash $defsArchiveFile -Algorithm SHA256).Hash

    # Generate new VERIFICATION.txt for the new version from template
    $markers = @{
        exeVersion = $Latest.ExeVersion
        defsVersion = $Latest.DefsVersion
        exeChecksum = $exeChecksum
        defsChecksum = $defsChecksum
    }
    Set-ReplaceMarkersInFile $verificationTemplateFile $verificationFile $markers

    # Cleaning up temporary files
    Remove-Item $exeArchiveFile -Force -ErrorAction Stop
    Remove-Item $definitionsDirectory -Recurse -Force -ErrorAction Stop

    # Renaming original license file to LICENSE.txt
    Rename-Item -Path $originalLicenseFile -NewName "LICENSE.txt"

    @{
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://mark0.net/soft-tridnet-e.html'

    # Version of the TrIDNet
    $versionRegex = ";TrIDNet v(\d+.\d+), <!-- MKHP SIZE /homepage-mark0/download/trid_net.zip"
    if ($download_page.content -match $versionRegex) {
        $exeVersion = $matches[1]
    }

    # Version of the defs. There is no version, so we will use the date of the defs refresh as the version number 
    $defsDateRegex = "/homepage-mark0/download/triddefs_xml.7z-->(\d+)/(\d+)/(\d+)<!-- MKHP -->\)"
    if ($download_page.content -match $defsDateRegex) {
        $day= $matches[1]
        $month = $matches[2]
        $year = $matches[3]
        $defsVersion = "$year$month$day"
    }

    # Version of the package is the combination of the versions of the TrIDNet and and the defs
    $version = "$exeVersion.$defsVersion"

    @{
        ExeVersion      = $exeVersion
        DefsVersion     = $defsVersion
        Version         = $version
    }
}

update -ChecksumFor none