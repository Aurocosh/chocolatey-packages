$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Haruna*'
  url64bit       = 'https://download.kde.org/stable/haruna/1.8.1/haruna-1.8.1-windows-gcc-x86_64.exe'
  checksum64     = '88760894f9ec8214a9af20aefc6beb4443d61c25dddb0373fd62642a7c0cc225'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /AllUsers'  # NSIS (KDE Craft)
}

Install-ChocolateyPackage @packageArgs
