$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Phoenix Code*'
  url64bit       = 'https://github.com/phcode-dev/phoenix-desktop/releases/download/prod-app-v5.5.11/Phoenix.Code_5.5.11_x64-setup.exe'
  checksum64     = 'ef7f0542e682c808c748074df38331b0ed9c7105e42164b29961ad92b7a0fd88'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

