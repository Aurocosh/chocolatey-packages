$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dorion*'
  url64bit       = 'https://github.com/SpikeHD/Dorion/releases/download/v6.9.1/Dorion_6.9.1_x64-setup.exe'
  checksum64     = '5c3232c733a380285cf2902e85e0d9f5a3c33df921e4884701c6916c9085ca55'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

