$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AmneziaVPN*'
  url64bit       = 'https://github.com/amnezia-vpn/amnezia-client/releases/download/5.1.1.10/AmneziaVPN_5.1.1.10_windows_x64.exe'
  checksum64     = '58ecdebd470cf74b5db081d18f0ab310d618b17f6defb55ce07804493c129d19'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = 'install --confirm-command --accept-messages --auto-answer installationErrorWithCancel=Ignore'
}

Install-ChocolateyPackage @packageArgs

