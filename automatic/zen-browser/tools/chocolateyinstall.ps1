$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.3/zen.installer.exe'
$checksumOptimized64 = 'ca10d32b545a23388503ad997e8f6dd2f6b75937ccc0e415d7b1dd0f9ec1b10b'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.3/zen.installer-generic.exe'
$checksumGeneric64 = '4a6b1bd8dd99cce3d69f644dff05b5de75e1582e523c94bfa710c6cb8305da4f'

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
