$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'FastFlix*'
  url64bit       = 'https://github.com/cdgriffith/FastFlix/releases/download/5.8.1/FastFlix_5.8.1_installer.exe'
  checksum64     = '57b16d0aac79fd78fcc32e085a03273355521e534a935af90f561d0407bda5a9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
