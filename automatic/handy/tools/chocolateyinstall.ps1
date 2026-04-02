$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Handy*'
  url64bit       = 'https://github.com/cjpais/Handy/releases/download/v0.8.2/Handy_0.8.2_x64-setup.exe'
  checksum64     = '7a55d1c4a3b024b2973cb4122d49ed8c599c87d1647e84f736632dff137c94bf'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

