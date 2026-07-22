$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.5.5/duckdb_cli-windows-amd64.zip'
  checksum64     = 'e1428b7114a841626b5054723731cbf45c6df91b42ae1a6c355f88fad1f6dc4c'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
