$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/5.0.1.5/AmneziaVPN_5.0.1.5_windows_x64.exe'
  checksum64     = '2e898bbd1d639f5066416961a2a458dba7c3455c0e8f49c7f130e9281d700377'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages --auto-answer installationErrorWithCancel=Ignore'
}

Install-ChocolateyPackage @packageArgs

