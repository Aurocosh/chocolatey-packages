$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$urlRegular64 = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/v0.11.0/lutgen-0.11.0-x86_64-windows.zip'
$checksumRegular64 = '500c3cfc9cf4567fa4758a1d3277df07580b9e41d3a6134020aab1429c9eba52'

$urlLegacy64 = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/v0.11.0/lutgen-0.11.0-x86_64-legacy-windows.zip'
$checksumLegacy64 = 'd85cb0dc98209720e7a0883a44ac2a3ad9d0e4865c1e55d5d83d5757e625a48e'

$PackageParameters = Get-PackageParameters

if ($PackageParameters.Legacy) {
  $url64 = $urlLegacy64
  $checksum64 = $checksumLegacy64
}
else {
  $url64 = $urlRegular64
  $checksum64 = $checksumRegular64
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'lutgen*'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
