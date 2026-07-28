$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.15.0/tea-0.15.0-windows-amd64.exe'
  checksum64     = '77f781de26085b5c1c70f4d27896fcab14c7439cf8fe59da0fcabfdbe26dceb7'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
