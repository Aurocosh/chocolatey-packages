$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'application*'
  url            = 'https://github.com/buckets/application/releases/download/v0.80.0/Buckets-Setup-0.80.0.exe'
  checksum       = 'f5880888935651a2ed5f25759247e24cb6cbbd2ecb6dc7f073f96780b5d93af3'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

