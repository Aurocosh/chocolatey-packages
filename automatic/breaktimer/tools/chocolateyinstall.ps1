$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'BreakTimer*'
  url64bit       = 'https://github.com/tom-james-watson/breaktimer-app/releases/download/v1.3.2/BreakTimer.exe'
  checksum64     = '57864086a7a4ca2f3bc6e35f41e808d887564e8b0a0203506df0c00480d9165a'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'
}

Install-ChocolateyPackage @packageArgs
