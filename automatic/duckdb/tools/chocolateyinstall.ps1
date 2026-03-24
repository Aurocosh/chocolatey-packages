$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.5.1/duckdb_cli-windows-amd64.zip'
  checksum64     = '22cc4b9dcffe6b01300d2e78b5918a13cf4335305fec854a9277db3bbf2e4a83'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
