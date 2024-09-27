$ErrorActionPreference = 'Stop' # stop on all errors

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2118.2/lime3ds-2118.2-windows-msvc-installer.exe'
$checksum64msvc = '190a5835f8650a57a330e2e5bda6bafa9259bcfa08f4fb07bbc7d2e6f130509e'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2118.2/lime3ds-2118.2-windows-msys2-installer.exe'
$checksum64msys2 = '1e1ae8cf66d6502c3eb20fbf28d0fb477c9aa1aa3fe7b4e37e46bb79d33e7d12'

$PackageParameters = Get-PackageParameters

if ($PackageParameters.MsysVersion) {
  $url64 = $url64msys2
  $checksum64 = $checksum64msys2
}
else {
  $url64 = $url64msvc
  $checksum64 = $checksum64msvc
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Lime3DS*'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
