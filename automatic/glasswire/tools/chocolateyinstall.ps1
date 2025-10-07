$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Glasswire*'
  url            = 'https://download.glasswire.com/f/glasswire-setup-3.7.880-full.exe'
  checksum       = 'cc31bedf69bcb43ee9b0269896fe76555e23352b5a777f4e62dddcaf777f530b'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
