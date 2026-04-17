$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'WizFile*'
  url64bit       = 'https://antibody-software.com/files/wizfile_3_15_setup.exe'
  checksum64     = 'd65d392bae45a2e95a3950fe09c5822e552db498067300450dc4729c4dca7917'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
