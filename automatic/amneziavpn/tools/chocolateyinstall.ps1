$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.15.4/AmneziaVPN_4.8.15.4_x64.exe'
  checksum64     = '9cae8601febd16461ad8f44614004e89402329355a9a44393759312e61b5ab80'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages'
}

Install-ChocolateyPackage @packageArgs

