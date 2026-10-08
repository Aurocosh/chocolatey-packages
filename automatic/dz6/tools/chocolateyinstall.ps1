$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'dz6*'
  url64bit       = 'https://github.com/mentebinaria/dz6/releases/download/v0.8.0/dz6-x86_64-pc-windows-msvc.zip'
  checksum64     = '4c5d3d2d41a3c4c60cf6a7d04cc7362a359096f68366973885e7f458ccd59bd4'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
