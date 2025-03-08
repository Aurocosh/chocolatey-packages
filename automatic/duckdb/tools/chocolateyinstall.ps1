$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.2.1/duckdb_cli-windows-amd64.zip'
  checksum64     = 'b0a7b85409f2aecf8535cb7daa8a29d9325b62850e5a24752a7146c65e3a32eb'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
