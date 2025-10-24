$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lychee.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.21.0/lychee-x86_64-windows.exe'
  checksum64     = 'a1784c32c63ba46dccef0698ddf6be82a83a7d0455b0fd772423d601e3c70ab4'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
