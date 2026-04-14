$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'WizFile*'
  url64bit       = 'https://antibody-software.com/files/wizfile_3_14_setup.exe'
  checksum64     = '2ac3e51cd8273f0f5dd49d34c04587fced5ad601d86abd7d39e42bd9593586fa'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
