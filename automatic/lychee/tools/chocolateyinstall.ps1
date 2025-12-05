$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.22.0/lychee-x86_64-windows.exe'
  checksum64     = '3f416d1243e7b65e23547e5995b0e3c3388c1bc6451d36764acfd3ee0e5c8968'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
