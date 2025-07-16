$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lutgen-cli.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/lutgen-studio-v0.2.1/lutgen-cli-v1.0.1-x86_64-pc-windows-msvc.exe'
  checksum64     = '436e99e6f873df80b955e0ab8f10b40c1bd493cbbda52872066c76dfd57215f9'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
