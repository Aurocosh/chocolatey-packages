$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.19.0/lychee-x86_64-windows.exe'
  checksum64     = 'aca1e6c89c3603fc83972d86ae3e517bef557a3620b0662e47e0a7b0010a84ed'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
