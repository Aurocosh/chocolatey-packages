$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Phoenix Code*'
  url64bit       = 'https://github.com/phcode-dev/phoenix-desktop/releases/download/prod-app-v5.1.24/Phoenix.Code_5.1.24_x64-setup.exe'
  checksum64     = '960908076ef0adcfbbf31a68290363f3ce16891cae067e9be3e73cfee1c44d62'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

