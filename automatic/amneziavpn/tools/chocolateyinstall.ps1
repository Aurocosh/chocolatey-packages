$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/5.0.3.0/AmneziaVPN_5.0.3.0_windows_x64.exe'
  checksum64     = 'd0e5c20696be89b65639cdc068d4337882ab9c2dbb1bde2a422ae26fb721298f'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages --auto-answer installationErrorWithCancel=Ignore'
}

Install-ChocolateyPackage @packageArgs

