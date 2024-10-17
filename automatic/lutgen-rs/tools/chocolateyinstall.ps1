$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$urlRegular64 = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/v0.11.2/lutgen-0.11.2-x86_64-windows.zip'
$checksumRegular64 = 'd91fadf04ce8ef2c1d7ce4befc79657bd700210f898486740c52349269089945'

$urlLegacy64 = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/v0.11.2/lutgen-0.11.2-x86_64-legacy-windows.zip'
$checksumLegacy64 = '3b75d971a26d1fbf2411e565494481765cbb446c8196f49bd6c659cd4ffe973b'

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
