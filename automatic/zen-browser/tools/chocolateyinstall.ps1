$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.6/zen.installer.exe'
$checksumOptimized64 = '30073077a83770dc3c13110d2499067343bc882fab51aef074479be492a40c3c'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.6/zen.installer-generic.exe'
$checksumGeneric64 = '06dafd606eaa54562de7c78fe28c197948a6b45796548ca3ca68b7f1e4039472'

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
