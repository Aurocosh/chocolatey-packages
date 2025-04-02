$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.6.0/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = '091b1bc53616b0804a503cdcfb3f85aece1299868bd94a0e51c7d4a9563a5120'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
