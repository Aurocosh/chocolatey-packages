$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.5.4/duckdb_cli-windows-amd64.zip'
  checksum64     = '09e27c773eaab396754cbaa8fdbc5055c0006db4a579439839c7bb671894610f'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
