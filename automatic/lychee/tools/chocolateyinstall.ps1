$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/v0.15.1/lychee-v0.15.1-windows-x86_64.exe'
  checksum64     = 'b75a5ba20d18fcd09b831451111d12501873ae7bdd5054819824f6e818e316f0'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
