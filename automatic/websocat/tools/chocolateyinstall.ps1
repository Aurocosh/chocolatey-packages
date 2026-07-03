$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'websocat.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'websocat*'
  url            = 'https://github.com/vi/websocat/releases/download/v1.14.1/websocat.i686-pc-windows-gnu.exe'
  checksum       = '06001c992fbbb5194ab162de6b47e9dad1dd8804c9840236a74fa72ea327f223'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/vi/websocat/releases/download/v1.14.1/websocat.x86_64-pc-windows-gnu.exe'
  checksum64     = '284339b5b86f2b11496137d97b6705bb2ef27e64f21527c1ba240bdb6177ba3b'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
