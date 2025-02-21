$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Miru*'
  url64bit       = 'https://github.com/ThaUnknown/miru/releases/download/v5.5.10/win-Miru-5.5.10-installer.exe'
  checksum64     = '6a2b1f809756306b17f9b5addbfdefc820dafc63788ae8ad7d158db053c42908'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
