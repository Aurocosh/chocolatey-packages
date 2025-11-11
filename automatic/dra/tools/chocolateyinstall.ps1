$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.9.1/dra-0.9.1-x86_64-pc-windows-msvc.zip'
  checksum64     = 'cfd6bbb6d84ae55244feac6c559380135b121819d4b13259f9fd5917fc2f1387'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
