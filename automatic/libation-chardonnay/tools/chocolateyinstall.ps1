$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Chardonnay)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v14.0.2/Libation.14.0.2-windows-chardonnay-x64-setup.exe'
  checksum64     = 'fa2517ab8be410536f67d1bd505ef2ca8fa0ce414cdae739a1581c06a024ff1b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

