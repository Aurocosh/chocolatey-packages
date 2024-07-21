$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'topgrade*'
  url64bit       = 'https://github.com/topgrade-rs/topgrade/releases/download/v15.0.0/topgrade-v15.0.0-x86_64-pc-windows-msvc.zip'
  checksum64     = 'e2f271fb1b6361c785c7d311483ea77739d4d5bfe73b7b694e76a0a6d08ec7ce'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
