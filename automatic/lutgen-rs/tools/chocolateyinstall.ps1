$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$urlRegular64 = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/v0.12.0/lutgen-0.12.0-x86_64-windows.zip'
$checksumRegular64 = '3541f8fd3b4b9236aeec5f5d91b39ab6728e077d9855723e49788fb4caa31081'

$urlLegacy64 = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/v0.12.0/lutgen-0.12.0-x86_64-legacy-windows.zip'
$checksumLegacy64 = '523dfc994668b2511a2b4a65fb012eec52e5b813467f7222be67aa7f752bf320'

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
