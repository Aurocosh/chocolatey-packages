$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'IntelliFile*'
  url64bit       = 'https://github.com/mihaimoga/IntelliFile/releases/download/v1.39/IntelliFileSetup.msi'
  checksum64     = '1b26870186f4fe56988df9d42565f66fc9e7ee9694bf3fb59b319c88afb8481a'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet'  # Windows Installer
}

Install-ChocolateyPackage @packageArgs
