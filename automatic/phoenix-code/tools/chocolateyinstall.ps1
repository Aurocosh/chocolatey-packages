$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Phoenix Code*'
  url64bit       = 'https://github.com/phcode-dev/phoenix-desktop/releases/download/prod-app-v5.2.4/Phoenix.Code_5.2.4_x64-setup.exe'
  checksum64     = 'a3cab1dfb7af7606f0907824e615b30f7ec7366e05c97c7139870be1ae49f516'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

