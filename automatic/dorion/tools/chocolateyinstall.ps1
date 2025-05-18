$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dorion*'
  url64bit       = 'https://github.com/SpikeHD/Dorion/releases/download/v6.6.1/Dorion_6.6.1_x64-setup.exe'
  checksum64     = '1d904bea769513997310fb3453c649f8047eb143fa8010d5d44ff6d86455c0e9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

