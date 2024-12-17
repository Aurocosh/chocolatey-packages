$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'houdoku*'
  url64bit       = 'https://github.com/xgi/houdoku/releases/download/v2.16.0/Houdoku-Setup-2.16.0.exe'
  checksum64     = '1ff6184dba55c8af2e05df197fe2ad42746a637c06ab673a3d2c4f0be01fe39a'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
