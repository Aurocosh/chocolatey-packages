$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/fujiapple852/trippy/releases/download/0.12.0/trippy-0.12.0-x86_64-pc-windows-msvc.zip'
$checksum64msvc = '081e668f58abd00940bb7244ea547bd3f499844a499de79e1494df9063442eb5'

$url64gnu = 'https://github.com/fujiapple852/trippy/releases/download/0.12.0/trippy-0.12.0-x86_64-pc-windows-gnu.zip'
$checksum64gnu = 'd9d4e5ece1f56e715d6e8b91ff1bec1eb4dc8f93e361da782bfc9a28430ddb52'

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
