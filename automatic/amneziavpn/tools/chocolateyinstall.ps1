$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.21.0/AmneziaVPN_4.8.21.0_windows_x64.exe'
  checksum64     = '2b6cfbf00965f34a6a3a163693041371c446842aede4dd73efaaeb3dd13ab996'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages'
}

Install-ChocolateyPackage @packageArgs

