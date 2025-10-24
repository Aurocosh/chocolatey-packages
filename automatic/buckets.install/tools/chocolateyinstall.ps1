$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'application*'
  url            = 'https://github.com/buckets/application/releases/download/v0.75.0/Buckets-Setup-0.75.0.exe'
  checksum       = '68D66AABB167E4A33121041987B75401837D8A0D5336F31F1A9CC2CF876D17A1'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

