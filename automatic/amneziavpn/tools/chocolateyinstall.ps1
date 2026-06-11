$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.17.0/AmneziaVPN_4.8.17.0_x64.exe'
  checksum64     = 'ea4774a43eff6017a8edfb55f4edd604af38874311f1ed6cc7c34fbba715d3d6'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages'
}

Install-ChocolateyPackage @packageArgs

