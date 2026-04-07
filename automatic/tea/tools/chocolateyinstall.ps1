$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.13.0/tea-0.13.0-windows-amd64.exe'
  checksum64     = '6665e32bd546baf3b68d7dca94be0abfe052d428b1e22c56c7d06d7c9accf805'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
