$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lutgen-cli.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/lutgen-v1.0.0/lutgen-cli-v-x86_64-pc-windows-msvc.exe'
  checksum64     = '721cc8d1aeb65ff3506b26ec7097cd90ef9b735d972f0835eb0128da11f8eff7'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
