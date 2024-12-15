$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.2/zen.installer.exe'
$checksumOptimized64 = '0050f7b7afae70b50f6de2b52742c92626030d75638cc1cc4178163cebee9eef'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.2-b.2/zen.installer-generic.exe'
$checksumGeneric64 = 'e30a39666a4711e49822f090ad93165450b5699ba0e23f0ea7ee329c01af77bc'

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
