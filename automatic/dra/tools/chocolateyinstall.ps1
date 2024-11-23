$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.7.0/dra-0.7.0-x86_64-pc-windows-msvc.zip'
  checksum64     = 'c53ecb1636ebbe70002faca4cf2303d14b3383d7a5eba43cf6af0c3c60acc93f'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
