$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lutgen-cli.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/lutgen-v1.0.1/lutgen-cli-v1.0.1-x86_64-pc-windows-msvc.exe'
  checksum64     = '197be902f1d430ebe7c2808a99e9f3cf355c8fc6b30199f068ee04bc64213a26'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
