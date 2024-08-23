$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'msi'
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.0.7/ABDownloadManager_1.0.7_windows.msi'
  checksum64     = '80205e9cac0f31b88380bbbf00fb4948382633e1a70c5bcedaccbe136a34b35a'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet'  # Windows Installer
}

Install-ChocolateyPackage @packageArgs
