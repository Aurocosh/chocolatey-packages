$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/fujiapple852/trippy/releases/download/0.10.0/trippy-0.10.0-x86_64-pc-windows-msvc.zip'
$checksum64msvc = '908a46fbdddee3abb9b9361cd69d8253d013d46b8bdcc1960fa1a17f61240c81'

$url64gnu = 'https://github.com/fujiapple852/trippy/releases/download/0.10.0/trippy-0.10.0-x86_64-pc-windows-gnu.zip'
$checksum64gnu = '908a46fbdddee3abb9b9361cd69d8253d013d46b8bdcc1960fa1a17f61240c81'

$PackageParameters = Get-PackageParameters

if (!$PackageParameters.GnuVersion) {
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
