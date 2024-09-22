$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Miru*'
  url64bit       = 'https://github.com/rainmeter/rainmeter/releases/download/v4.5.20.3803/Rainmeter-4.5.20.exe'
  checksum64     = '9024b3b01b3883af3e12c3023ca9f7569893d25bb8154d785ac5737c7fff3ac9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
