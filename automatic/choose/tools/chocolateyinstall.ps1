$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'choose.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'choose*'
  url64bit       = 'https://github.com/theryangeary/choose/releases/download/v1.3.7/choose-x86_64-pc-windows-gnu.exe'
  checksum64     = '9233beade020c3e74854911a15aa973f7dc9f4253abe8856b8c273579a555903'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
