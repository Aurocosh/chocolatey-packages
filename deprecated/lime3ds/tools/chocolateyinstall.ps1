$ErrorActionPreference = 'Stop' # stop on all errors

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2119.1/lime3ds-2119.1-windows-msvc-installer.exe'
$checksum64msvc = '020f500305362e07b2fa971b8628cd31b1be0bdde760c1e35158ed4b8c22d953'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2119.1/lime3ds-2119.1-windows-msys2-installer.exe'
$checksum64msys2 = '50684e939766d197fe466bfe92c11bc28511e020eca93382c68fdde3b4ee9156'

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
