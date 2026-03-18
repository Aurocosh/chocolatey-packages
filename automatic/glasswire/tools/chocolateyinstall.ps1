$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Glasswire*'
  url            = 'https://s3.us-east-1.amazonaws.com/s3.glasswire.com/download/cdd8444f47c3e9bd2b3e094adf92a9eb/GlassWireSetup.exe'
  checksum       = 'f3700baa2bb95d8a718c53cab25cd4d665a6d95d40c178abf66f4d587c51371b'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
