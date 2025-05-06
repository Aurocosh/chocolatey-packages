$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/fujiapple852/trippy/releases/download/0.13.0/trippy-0.13.0-x86_64-pc-windows-msvc.zip'
$checksum64msvc = '74a184434d96eec6c7f8e4b467147c40fa8841fa3722a3ddf51267208fcbbbe6'

$url64gnu = 'https://github.com/fujiapple852/trippy/releases/download/0.13.0/trippy-0.13.0-x86_64-pc-windows-gnu.zip'
$checksum64gnu = 'edeff2f9705c10d94cfb4f53ec5ca53489dad85f77af9f117436720256b4fe51'

$PackageParameters = Get-PackageParameters

if ($PackageParameters.GnuVersion) {
  $url64 = $url64gnu
  $checksum64 = $checksum64gnu
}
else {
  $url64 = $url64msvc
  $checksum64 = $checksum64msvc
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'Trippy*'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
