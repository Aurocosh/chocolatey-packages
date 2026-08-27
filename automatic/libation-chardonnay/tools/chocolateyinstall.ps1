$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Chardonnay)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v14.0.0/Libation.14.0.0-windows-chardonnay-x64-setup.exe'
  checksum64     = 'cecc39860dd9fea0233929c4e8cdb30a8cfc9e663e8d778fa5977888e6df2efb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

