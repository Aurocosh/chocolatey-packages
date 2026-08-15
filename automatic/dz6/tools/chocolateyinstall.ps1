$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'dz6*'
  url64bit       = 'https://github.com/mentebinaria/dz6/releases/download/v0.7.1/dz6-x86_64-pc-windows-msvc.zip'
  checksum64     = 'd7e9ae24adcf056c2cc0431a5763427a504508c14e3acc0eddd3f54892bd253e'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
