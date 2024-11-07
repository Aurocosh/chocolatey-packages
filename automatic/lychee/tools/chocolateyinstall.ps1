$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.17.0/lychee-x86_64-windows.exe'
  checksum64     = '5a4dfd2e987321ae171fe1e46ec87adaa837b644a2478552f775d372590322ec'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
