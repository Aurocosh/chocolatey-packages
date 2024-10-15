$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.9/zen.installer.exe'
$checksumOptimized64 = '387f472d45fb6d82e541fe8921534f87ad0bf03cce3e4df4f42480d744a721eb'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.9/zen.installer-generic.exe'
$checksumGeneric64 = 'e4daf5167e46cbb440d62a9a2a2a2744cf27c28c119607dd33a60742a62d1d91'

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
