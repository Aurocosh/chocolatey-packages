$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.5.0/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = '71a1736348a2ddfe6af48c757125d4b55b567fbc123ce10652caeab6a9173acb'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
