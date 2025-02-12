$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.18.1/lychee-x86_64-windows.exe'
  checksum64     = '40dc64ff4d64426cbbc41c410faa01fcd807af15d965c2eea6bbc795a32d6f3c'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
