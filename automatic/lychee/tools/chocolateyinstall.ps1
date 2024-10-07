$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.16.1/lychee-x86_64-windows.exe'
  checksum64     = '7c97ce777e49ae6f5f2185805c13abc8e987754fb7246c20f2086871853d4180'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
