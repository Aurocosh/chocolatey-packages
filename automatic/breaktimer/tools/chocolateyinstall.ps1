$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'BreakTimer*'
  url64bit       = 'https://github.com/tom-james-watson/breaktimer-app/releases/download/v2.0.1/BreakTimer.exe'
  checksum64     = '1344be67451247575b10dd62aedcb169a343e9ddedbf7bacde1e8dd4c8ebf27d'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'
}

Install-ChocolateyPackage @packageArgs
