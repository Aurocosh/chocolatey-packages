$ErrorActionPreference = 'Stop' # stop on all errors

$urlOptimized64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.5/zen.installer.exe'
$checksumOptimized64 = '87173726b70d35149b1de0e6357557ddeeae5a97d31296bf6be56fe69412806b'

$urlGeneric64 = 'https://github.com/zen-browser/desktop/releases/download/1.0.1-a.5/zen.installer-generic.exe'
$checksumGeneric64 = '7b642f075be6be613983d93ce9cfce95ec994ec9ab8cc8984991b90034fa3079'

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
