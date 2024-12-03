$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dorion*'
  url64bit       = 'https://github.com/SpikeHD/Dorion/releases/download/v6.3.0/Dorion_6.3.0_x64-setup.exe'
  checksum64     = 'ab2ea683a3e5fd7a3f825f7cf568c1559c0e31fd7ea796c7e8e5166e2d142cf1'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

