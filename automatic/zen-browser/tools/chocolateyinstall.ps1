$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.1/zen.installer.exe'
$checksumOptimized64 = '9ce4009e101e54790c4a4b981e87085849e37307816530ef7b10ff32ce6e86df'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.1/zen.installer-generic.exe'
$checksumGeneric64 = 'd5ec4431b6fa6ea3d967257beba6b71bebe0350a932ef26ba8d0dce6e67f102b'

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
