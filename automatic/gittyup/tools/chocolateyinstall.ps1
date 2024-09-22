$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Gittyup*'
  url            = 'https://github.com/Murmele/Gittyup/releases/download/gittyup_v1.4.0/Gittyup-win32-1.4.0.exe'
  checksum       = '0b1076c7ec7141d1c5b989d36c00011cd61e0fde646f59be208c9fbabe5eb836'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/Murmele/Gittyup/releases/download/gittyup_v1.4.0/Gittyup-win64-1.4.0.exe'
  checksum64     = 'ab86d29dffd131718d2c2d0149ce90e6ad46e624e205e4feead011a800cd9302'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
