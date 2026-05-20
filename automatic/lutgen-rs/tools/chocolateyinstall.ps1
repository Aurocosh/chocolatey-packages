$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'lutgen-cli.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ozwaldorf/lutgen-rs/releases/download/lutgen-v1.1.1/lutgen-cli-v-x86_64-pc-windows-msvc.exe'
  checksum64     = '2eecd30d587b8e62ea48fc0f9ddf542e5bafbb0aa29408cdbb649164ba0cc22c'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
