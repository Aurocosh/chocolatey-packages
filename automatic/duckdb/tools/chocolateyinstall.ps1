$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.3.2/duckdb_cli-windows-amd64.zip'
  checksum64     = '0f20f96cc83540817e9e42f88d1f62e5452a9a2b4fcdef7f97cfc94a971d313f'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
