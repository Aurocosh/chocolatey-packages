$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.19.1/lychee-x86_64-windows.exe'
  checksum64     = 'b885d3403bc5e349c5307289021e57f5d2232c4de398c7813855100114c61ebc'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
