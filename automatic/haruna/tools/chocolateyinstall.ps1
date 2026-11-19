$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Haruna*'
  url64bit       = 'https://download.kde.org/stable/haruna/1.9.1/haruna-1.9.1-windows-mingw-x86_64.exe'
  checksum64     = '3d98c37d90aa98649df967094cbabbd1433621a56de6aaf411660f7ed5b30dfb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /AllUsers'  # NSIS (KDE Craft)
}

Install-ChocolateyPackage @packageArgs
