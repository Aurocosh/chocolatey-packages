$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.6.1/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = '4db561002edffc458a1fb2bf0208f6e8800bdcf929156e01c4cce22c52ecb0fe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
