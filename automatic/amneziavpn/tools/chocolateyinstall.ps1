$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/5.1.0.6/AmneziaVPN_5.1.0.6_windows_x64.exe'
  checksum64     = 'ed9b3794d90e5979579b05e8cd57721a21755e19bf80a7451221c3bd12995598'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages --auto-answer installationErrorWithCancel=Ignore'
}

Install-ChocolateyPackage @packageArgs

