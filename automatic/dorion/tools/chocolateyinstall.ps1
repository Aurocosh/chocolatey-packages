$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dorion*'
  url64bit       = 'https://github.com/SpikeHD/Dorion/releases/download/v6.12.2/Dorion_6.12.2_x64-setup.exe'
  checksum64     = '467c364f588ec62ee5dc1474aefe05e9d3189d57c842a327a9ef60a149a7f4de'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

