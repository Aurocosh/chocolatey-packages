$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'RStudio*'
  url64bit       = 'https://download1.rstudio.org/electron/windows/RStudio-2026.10.1-239.exe'
  checksum64     = '215bc4bb4d0c2d4bb343141b0b6f220c39ded9ec281f4bd0bd9951325de68222'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'  # NSIS
}

Install-ChocolateyPackage @packageArgs
