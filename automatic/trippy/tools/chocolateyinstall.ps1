$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/fujiapple852/trippy/releases/download/0.11.0/trippy-0.11.0-x86_64-pc-windows-msvc.zip'
$checksum64msvc = 'ff0e7514597560fbfe19d9efaf7037888036c46d96a959c8332940ea2495984c'

$url64gnu = 'https://github.com/fujiapple852/trippy/releases/download/0.11.0/trippy-0.11.0-x86_64-pc-windows-gnu.zip'
$checksum64gnu = 'aa112df24eee670ffee7297890ca01377d503efef48d30421ef5a40465bd69f0'

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
