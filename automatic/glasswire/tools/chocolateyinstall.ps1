$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Glasswire*'
  url            = 'https://download.glasswire.com/f/glasswire-setup-3.8.1061-full.exe'
  checksum       = 'f68b016a9d72ac1d34164ff753803d146ee0a770c94a0e47718a7fb34a4082c2'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
