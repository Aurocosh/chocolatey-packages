$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Miru*'
  url64bit       = 'https://github.com/ThaUnknown/miru/releases/download/v5.5.6/win-Miru-5.5.6-installer.exe'
  checksum64     = '330471973044d1ff265456fb532dc2c391780848277ba445648ee7e49829b469'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
