$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'RStudio*'
  url64bit       = 'https://download1.rstudio.org/electron/windows/RStudio-2026.08.1-195.exe'
  checksum64     = 'b867e71732ca89c5fe5de8b3f6a1b038e2a8545e4a8083c381fb12362fc81480'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'  # NSIS
}

Install-ChocolateyPackage @packageArgs
