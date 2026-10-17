$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'RStudio*'
  url64bit       = 'https://download1.rstudio.org/electron/windows/RStudio-2026.10.0-233.exe'
  checksum64     = 'f5d0d21bbc1247e7dd9611784bb3503d3eac903cb9e83ae3ab355947bdeed060'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'  # NSIS
}

Install-ChocolateyPackage @packageArgs
