$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.2.2/duckdb_cli-windows-amd64.zip'
  checksum64     = '9d35fba121f011b06d5f256c2ac351ae5c2468de8156524c75082b2e4a810ffe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
