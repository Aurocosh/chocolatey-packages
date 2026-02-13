$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Handy*'
  url64bit       = 'https://github.com/cjpais/Handy/releases/download/v0.7.5/Handy_0.7.5_x64-setup.exe'
  checksum64     = '3e3421fa307652c0cb6817d735eef8af712d678d8f7c14d4b5ca2eb9719411b9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

