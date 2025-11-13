$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.4.2/duckdb_cli-windows-amd64.zip'
  checksum64     = '2a31d67cf54aec3494fb331147edddfee1cd7f3fadcb5b84056f9bc28cf76576'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
