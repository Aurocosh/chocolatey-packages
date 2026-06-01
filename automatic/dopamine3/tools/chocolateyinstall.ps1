$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dopamine*'
  url64bit       = 'https://github.com/digimezzo/dopamine/releases/download/v3.0.5/Dopamine-3.0.5.exe'
  checksum64     = 'a9af286cfe3c77bfcc0b7b0c64704dac46b1ae356765a4fd07fed8c53c9ed7cb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

