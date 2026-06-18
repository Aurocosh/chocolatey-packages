$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'dz6*'
  url64bit       = 'https://github.com/mentebinaria/dz6/releases/download/v0.7.0/dz6-x86_64-pc-windows-msvc.zip'
  checksum64     = '90f82558ac56d910f997d2e5b6a20aad5967fb00b676bb77985c1ca7b0262b9f'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
