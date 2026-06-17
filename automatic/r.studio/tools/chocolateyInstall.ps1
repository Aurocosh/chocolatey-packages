$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'RStudio*'
  url64bit       = 'https://download1.rstudio.org/electron/windows/RStudio-2026.05.1-225.exe'
  checksum64     = '8d5faa42bd0ddfb82ae5d484349ccd82c9bca2f55143bd44502fae44144c7b24'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
