$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Classic)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v14.2.0/Libation-Classic.14.2.0-windows-classic-x64-setup.exe'
  checksum64     = '8e3d689729b83a05b2eb4f1684bbb7c00d769773b2613fa9059d368dfd6d2f5f'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

