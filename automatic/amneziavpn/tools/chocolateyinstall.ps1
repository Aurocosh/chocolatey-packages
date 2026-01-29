$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.12.9/AmneziaVPN_4.8.12.9_x64.exe'
  checksum64     = '52438648799e163e6e0d877d297f0dac2ab22348d20a002026d4fb50bfb766ad'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages'
}

Install-ChocolateyPackage @packageArgs

