$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Phoenix Code*'
  url64bit       = 'https://github.com/phcode-dev/phoenix-desktop/releases/download/prod-app-v5.2.5/Phoenix.Code_5.2.5_x64-setup.exe'
  checksum64     = '52a7a782d3a3515cda172330e84c5cb4263379dfdd2271fb852d7bd1059b66eb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

