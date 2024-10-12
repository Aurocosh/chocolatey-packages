$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'wmocr*'
  url            = 'https://github.com/Aurocosh/wmocr/releases/download/1.0.0/wmocr-win-x86.zip'
  checksum       = 'd5380bc500394316922c735916d8f1f3ead1d6c40f2d785b06f6e5aead6760e2'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/Aurocosh/wmocr/releases/download/1.0.0/wmocr-win-x64.zip'
  checksum64     = 'b75af0761b0561533dbf6ce0598cd3d6a1495f5cc3d5561cad4a21d273c067f0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
