$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Classic)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v14.2.4/Libation-Classic.14.2.4-windows-classic-x64-setup.exe'
  checksum64     = 'a4d080fb1e52ccc367e7bb80e30c055af5a7297185e3c051d8d8e45d02c12fd5'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

