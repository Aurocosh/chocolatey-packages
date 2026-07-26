$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Classic)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v13.6.0/Libation-Classic.13.6.0-windows-classic-x64-setup.exe'
  checksum64     = '0cee35cbe7841381cb02958f8e5e15d2485a4e1ebc43c500aca0a7881fb056bf'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

