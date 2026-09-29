$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.5.6/duckdb_cli-windows-amd64.zip'
  checksum64     = '798eae475d07c645ff3b914f7b0e676d06502b5412dd7552638fafed81f9e916'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
