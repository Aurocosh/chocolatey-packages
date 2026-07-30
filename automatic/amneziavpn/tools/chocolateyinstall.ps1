$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/5.0.0.5/AmneziaVPN_5.0.0.5_windows_x64.exe'
  checksum64     = '7c27606a1b899e325b5a421557adda41bd16c903496e4d42c2e480ce4cc0ec40'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages --auto-answer installationErrorWithCancel=Ignore'
}

Install-ChocolateyPackage @packageArgs

