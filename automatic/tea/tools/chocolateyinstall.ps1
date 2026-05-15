$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.14.1/tea-0.14.1-windows-amd64.exe'
  checksum64     = 'f4cb89a18601bd2efb5ef49b6fc75db275c46a0bad09a5d2ecf84ba1147fdf77'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
