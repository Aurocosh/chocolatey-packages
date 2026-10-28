$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Classic)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v14.2.5/Libation-Classic.14.2.5-windows-classic-x64-setup.exe'
  checksum64     = '82901a6bcab66ea21fb899daf19fb1c370fe8c985d1b1c0bb8c7d59d09233adf'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

