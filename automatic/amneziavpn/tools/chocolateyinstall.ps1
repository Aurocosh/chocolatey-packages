$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'amnezia-client*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.10.0/AmneziaVPN_4.8.10.0_windows_x64.exe'
  checksum64     = 'f541646b4b2b5be4394d695a9b94f71f1a36d1869027ab8256d7048185c7df78'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages'
}

Install-ChocolateyPackage @packageArgs

