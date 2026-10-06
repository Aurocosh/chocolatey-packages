$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Rainmeter*'
  url64bit       = 'https://github.com/rainmeter/rainmeter/releases/download/v4.5.27.3934/Rainmeter-4.5.27.exe'
  checksum64     = '1c10c8dae65f7e333dbc2eca88af2951c7bfd6647ec72f97673bf102a1c9619b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
