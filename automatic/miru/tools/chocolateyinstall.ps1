$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Miru*'
  url64bit       = 'https://github.com/ThaUnknown/miru/releases/download/v5.5.9/win-Miru-5.5.9-installer.exe'
  checksum64     = '39f57759eb07d181e4d743594f021411ca89b1b107c42e18301aad17d8bb33b5'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
