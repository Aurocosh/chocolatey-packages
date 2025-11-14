$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'BreakTimer*'
  url64bit       = 'https://github.com/tom-james-watson/breaktimer-app/releases/download/v2.0.3/BreakTimer.exe'
  checksum64     = '61122518bb6de92413a9dd06df2e7fe55fdf15479812e52e11dbb44334bee4d9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'
}

Install-ChocolateyPackage @packageArgs
