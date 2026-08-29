$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.10.3/dra-0.10.3-x86_64-pc-windows-msvc.zip'
  checksum64     = '396c44d18a92fe5584e42417f218a312cf6df856a9d966c162466c85de4b1359'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
