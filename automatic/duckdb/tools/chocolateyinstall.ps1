$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.5.3/duckdb_cli-windows-amd64.zip'
  checksum64     = '2aba634fab91b3cb3f88cb7a75a9539b47ef240a76f4d4ff8d1e48821c8ccd7f'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
