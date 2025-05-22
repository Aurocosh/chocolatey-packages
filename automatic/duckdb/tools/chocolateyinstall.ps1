$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.3.0/duckdb_cli-windows-amd64.zip'
  checksum64     = 'a04f7bdc21f077a4f7ce931d8de85f3606a46663f6ca413d3142df22a856d895'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
