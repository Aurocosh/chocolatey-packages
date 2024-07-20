$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  url64bit       = 'https://github.com/sonosaurus/sonobus/releases/download/1.7.2/sonobus-1.7.2-win.exe'
  checksum64     = '9790d2dee5aee327dc4dbd69e43567ece833d41645a35f8adb05b3c39243cfd8'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT'
}

Install-ChocolateyPackage @packageArgs
