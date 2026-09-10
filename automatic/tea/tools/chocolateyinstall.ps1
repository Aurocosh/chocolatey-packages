$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.16.0/tea-0.16.0-windows-amd64.exe'
  checksum64     = '3f42442c77ed8fee218186376cb2bfdfc52a4d2d5ecbf08c5552a290d3d08fdd'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
