$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.0/zen.installer.exe'
$checksumOptimized64 = 'c954713a5dd754d44ee148749e9bafcc615d03e4c74afd7b9f017dc2e2f26880'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.0/zen.installer-generic.exe'
$checksumGeneric64 = '93489dd29edc992a08fcf0e62d44bf3dd0db3b3a96f61d78f0416fe714248b85'

$PackageParameters = Get-PackageParameters

if ($PackageParameters.Optimized) {
  $url64 = $urlOptimized64
  $checksum64 = $checksumOptimized64
}
else {
  $url64 = $urlGeneric64
  $checksum64 = $checksumGeneric64
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Zen Browser*'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
