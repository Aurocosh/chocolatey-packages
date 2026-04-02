$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.7.1/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = 'f76a635add18586c9473329fb37d2dca831b80d8062dccb4683f69a3bb3de5e6'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
