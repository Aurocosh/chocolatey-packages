$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'lychee*'
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.24.1/lychee-x86_64-pc-windows-msvc.zip'
  checksum64     = '34a12a7da946e4db1babe8cb3f7549e036129d524b36f2baf3068acdef66d0c3'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
