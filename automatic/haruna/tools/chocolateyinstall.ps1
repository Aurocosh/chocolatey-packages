$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Haruna*'
  url64bit       = 'https://download.kde.org/stable/haruna/1.9.0/haruna-1.9.0-windows-mingw-x86_64.exe'
  checksum64     = '86dd72865ab402bf6ab24e42c212d37041a7508d12ebda84b38f037f61df9c3b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /AllUsers'  # NSIS (KDE Craft)
}

Install-ChocolateyPackage @packageArgs
