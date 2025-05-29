$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.8.2/dra-0.8.2-x86_64-pc-windows-msvc.zip'
  checksum64     = '828d617b4391ac737b8fe7337b3a3dcfc3bff3dc810692e1c431b8d53cee6eff'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
