$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.4.3/duckdb_cli-windows-amd64.zip'
  checksum64     = '6af7c45f38d764d1c8345f1cb1b1f2d07d779e11125ddf5dca7f2dfdf50efc7e'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
