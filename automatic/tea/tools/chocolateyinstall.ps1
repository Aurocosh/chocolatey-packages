$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.14.0/tea-0.14.0-windows-amd64.exe'
  checksum64     = '5f5315a8e0e520e92c0fd8f27c027c26717f68c3f4ee5d33c08a75cfa26f1e0e'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
