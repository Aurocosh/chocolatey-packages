$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Handy*'
  url64bit       = 'https://github.com/cjpais/Handy/releases/download/v0.10.1/Handy_0.10.1_x64-setup.exe'
  checksum64     = '3d0c05cfe2717370e64ca71e6cb36dd575d8b0f28424f48e00efe18565a04edf'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

