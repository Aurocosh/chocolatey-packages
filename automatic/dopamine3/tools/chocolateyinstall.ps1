$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dopamine*'
  url64bit       = 'https://github.com/digimezzo/dopamine/releases/download/v3.0.0-preview.40/Dopamine-3.0.0-preview.40.exe'
  checksum64     = '1c9888e6d6ac7e0177281b80c71d4c1d9a7fbcd7f77ccd82f4ed19e4d57abbeb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

