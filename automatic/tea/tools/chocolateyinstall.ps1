$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.14.2/tea-0.14.2-windows-amd64.exe'
  checksum64     = '51f6e03fb6b7a542c51d3b307075bc5fdc9874c1cc2ced3b2ee5add2da235d88'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
