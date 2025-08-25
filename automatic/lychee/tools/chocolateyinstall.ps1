$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.20.1/lychee-x86_64-windows.exe'
  checksum64     = 'dbd2f1ba07ef1725b37aa5069121365a2a96fbaa84a9905d678add623ff021df'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
