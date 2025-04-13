$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Rainmeter*'
  url64bit       = 'https://github.com/rainmeter/rainmeter/releases/download/v4.5.23.3836/Rainmeter-4.5.23.exe'
  checksum64     = 'a613e59a8e51511330b9da874a2fc928266f44ca4febb117910001bb3d9c5e69'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
