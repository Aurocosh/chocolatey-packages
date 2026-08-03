$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.15.1/tea-0.15.1-windows-amd64.exe'
  checksum64     = 'd59cda2463b9f0b1c29ff69834650ba8d8dfa327a79a38f2cfc6e28f61bcb166'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
