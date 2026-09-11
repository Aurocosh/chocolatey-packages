$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'RStudio*'
  url64bit       = 'https://download1.rstudio.org/electron/windows/RStudio-2026.09.0-174.exe'
  checksum64     = 'e6b5a3b1028b7cc8d2abe7375aae4813a791898899d81d64468185349e41491c'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'  # NSIS
}

Install-ChocolateyPackage @packageArgs
