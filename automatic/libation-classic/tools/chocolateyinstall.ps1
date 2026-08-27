$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Classic)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v14.0.0/Libation-Classic.14.0.0-windows-classic-x64-setup.exe'
  checksum64     = 'e60c1f9f865d5830e1f3719350391616a68a28c9f6e8c1743a97c0be0613bf13'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

