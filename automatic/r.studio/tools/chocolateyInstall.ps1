$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'RStudio*'
  url64bit       = 'https://download1.rstudio.org/electron/windows/RStudio-2026.08.2-200.exe'
  checksum64     = 'b246a1cc3c61b7c56555d99393dd19fa377be9a6c6b874fc54836671cebf5f0c'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'  # NSIS
}

Install-ChocolateyPackage @packageArgs
