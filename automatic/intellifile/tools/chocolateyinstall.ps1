$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'IntelliFile*'
  url64bit       = 'https://github.com/mihaimoga/IntelliFile/releases/download/v1.33/IntelliFileSetup.msi'
  checksum64     = '5c972ee68fe282fd54e98986e9b226b4eb3cb9c675ccf921409a5983afbef6ea'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet'  # Windows Installer
}

Install-ChocolateyPackage @packageArgs
