$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'BreakTimer*'
  url64bit       = 'https://github.com/tom-james-watson/breaktimer-app/releases/download/v1.3.0/BreakTimer.exe'
  checksum64     = 'e0f1e185fd1f4280b114c1c736c0acde1b60900ab9bd7abeafeffe9b33fe4b11'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'
}

Install-ChocolateyPackage @packageArgs
