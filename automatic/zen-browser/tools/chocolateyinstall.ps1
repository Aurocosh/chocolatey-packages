$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.7/zen.installer.exe'
$checksumOptimized64 = '63489508238e2a85d250df003a630ecb2fbc201f56f5cf5311bd88b9eab50f62'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.7/zen.installer-generic.exe'
$checksumGeneric64 = '1999ef211d53127d8711dfe5a2a6378f06e2dd77fd66ea3422325f6b24aabbe4'

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
