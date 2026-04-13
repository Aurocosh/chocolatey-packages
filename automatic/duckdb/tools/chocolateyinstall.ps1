$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.5.2/duckdb_cli-windows-amd64.zip'
  checksum64     = 'd7b4f5774419c2e9eb14cb7361d3488821ef0244f8af461fd2c6fcb6f43bc3e0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
