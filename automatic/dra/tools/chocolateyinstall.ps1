$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.10.0/dra-0.10.0-x86_64-pc-windows-msvc.zip'
  checksum64     = '3b68e4afe632369543249390210468427a60737f9b8bd83bd3ad671f7dc2aedf'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
