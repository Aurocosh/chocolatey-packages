$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/fujiapple852/trippy/releases/download/0.12.1/trippy-0.12.1-x86_64-pc-windows-msvc.zip'
$checksum64msvc = '0d288450f828585c114a14241c0be25710291e12913b7a0742cd69becc5c789d'

$url64gnu = 'https://github.com/fujiapple852/trippy/releases/download/0.12.1/trippy-0.12.1-x86_64-pc-windows-gnu.zip'
$checksum64gnu = '0bdb55bf03443671b8f5e2563041532f6c0a83dd6c5f124d0c850a817c7295f1'

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
