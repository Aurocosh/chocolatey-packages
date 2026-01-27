$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.4.4/duckdb_cli-windows-amd64.zip'
  checksum64     = 'cd24e5736ac69a33dc1411209f161ded5595ffc578e3cf016474346c64a87f5e'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
