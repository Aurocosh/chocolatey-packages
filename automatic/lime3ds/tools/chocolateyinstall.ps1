$ErrorActionPreference = 'Stop' # stop on all errors

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2118.1/lime3ds-2118.1-windows-msvc.exe'
$checksum64msvc = 'ece36ec88fc881399cf4d344803e124bee0d5989a4bddf40f4d82e6b1adceece'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2118.1/lime3ds-2118.1-windows-msys2.exe'
$checksum64msys2 = '48744857c88de343bcc883191a6ca62f350c5e0cf355b5304315b769f41de837'

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
