$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.23.0/lychee-x86_64-windows.exe'
  checksum64     = '0fda7ff0a60c0250939fc25361c2d4e6e7853c31c996733fdd5a1dd760bcb824'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
