$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.4.0/duckdb_cli-windows-amd64.zip'
  checksum64     = 'efceab16ece9e6be24ddd1ce82a58ca23d27bc4c5defbea40e3bcb82adeed41a'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
