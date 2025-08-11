$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'BreakTimer*'
  url64bit       = 'https://github.com/tom-james-watson/breaktimer-app/releases/download/v2.0.0/BreakTimer.exe'
  checksum64     = '976a0ea51498e9c029215416d124c32a8f871127028039515ab460136470c14d'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'
}

Install-ChocolateyPackage @packageArgs
