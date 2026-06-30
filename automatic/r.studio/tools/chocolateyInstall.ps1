$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'RStudio*'
  url64bit       = 'https://download1.rstudio.org/electron/windows/RStudio-2026.06.0-242.exe'
  checksum64     = '09aab92c230f77f05f0d98b293405c27f81bd5ca2865e85ccc9378256a5eb9ed'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
