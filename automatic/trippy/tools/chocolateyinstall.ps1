$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/fujiapple852/trippy/releases/download/0.12.2/trippy-0.12.2-x86_64-pc-windows-msvc.zip'
$checksum64msvc = 'a44a2de5d3f7536d0e5cc2f32665c8e39215dca5961889925c6048c318a169d8'

$url64gnu = 'https://github.com/fujiapple852/trippy/releases/download/0.12.2/trippy-0.12.2-x86_64-pc-windows-gnu.zip'
$checksum64gnu = '5e8b801c4f0f3ce8baadd413790c2dcf9ef06d771d84cae7b310ca81d2ee690f'

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
