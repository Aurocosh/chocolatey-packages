$ErrorActionPreference = 'Stop' # stop on all errors
$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $tempPath
    softwareName   = 'Russian - Phonetic - SI*'
    url            = 'https://github.com/Aurocosh/keyboard-layout-ru-si/releases/download/1.0.0/ru_si-1.0.0.zip'
    checksum       = 'c9082a50f49fe53bd99c0b3de09815c03a500093ddaea73fb9f5644e0488bd8a'
    checksumType   = 'sha256'
    validExitCodes = @(0, 3010, 1641)
    silentArgs     = '/quiet /qn /norestart'  # MSI
    disableLogging = $true
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs.file = Join-Path $tempPath "Ru_SI_i386.msi"
$packageArgs.file64 = Join-Path $tempPath "Ru_SI_amd64.msi"
$packageArgs.fileType = 'msi'

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
