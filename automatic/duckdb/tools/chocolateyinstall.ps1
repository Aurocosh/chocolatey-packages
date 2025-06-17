$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.3.1/duckdb_cli-windows-amd64.zip'
  checksum64     = 'a9f51426860649158c3d89a04fa7c741343c545237ced49c60cf67e065e9c828'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
