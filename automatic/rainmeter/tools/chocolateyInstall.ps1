$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Rainmeter*'
  url64bit       = 'https://github.com/rainmeter/rainmeter/releases/download/v4.5.21.3816/Rainmeter-4.5.21.exe'
  checksum64     = 'ee7dce6ed4f591210b70134a24c4fd0159fe46a5de0f3726e0dc618b7bda51e2'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
