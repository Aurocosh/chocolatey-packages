$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.18.0/lychee-x86_64-windows.exe'
  checksum64     = '59fbbd09804609b46ac4c9ee1543bc5ff12a9cd344449fb761c0ba47e2d09f6e'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
