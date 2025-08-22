$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.20.0/lychee-x86_64-windows.exe'
  checksum64     = '238f89068c28a3d14ab6515ec71a974770b248bef1b1d08b8454941ea21b8291'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
