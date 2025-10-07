$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.4.1/duckdb_cli-windows-amd64.zip'
  checksum64     = '3fab5174658bf16189c80eaa047b3e7737847491c9e4433a985adf014618cbd9'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
