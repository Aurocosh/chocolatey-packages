$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.8/zen.installer.exe'
$checksumOptimized64 = 'e33ea77c6a9574b3af3dbd8f6a8bbaa2639fc0b5a1e4e6f944b69ab30d028ff7'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.8/zen.installer-generic.exe'
$checksumGeneric64 = '334470050422616ba6bc7be002b881b60cdeafd63651811ea50f7d82aaf8556e'

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
