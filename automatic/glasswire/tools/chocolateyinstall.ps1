$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Glasswire*'
  url            = 'https://s3.us-east-1.amazonaws.com/s3.glasswire.com/download/42355969649152f92738c28f050453e3/GlassWireSetup.exe'
  checksum       = '47780711f5c5e0316c7ecd5926ea8d43f74e7d333310407bed5525f6f482d5c0'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
