$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'duckdb*'
  url64bit       = 'https://github.com/duckdb/duckdb/releases/download/v1.5.0/duckdb_cli-windows-amd64.zip'
  checksum64     = '90d5187208939cffce62736c7293d7efb25aed057c23afb5a17296c1a2c236de'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
