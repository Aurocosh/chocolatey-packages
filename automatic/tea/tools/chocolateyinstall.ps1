$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.11.1/tea-0.11.1-windows-amd64.exe'
  checksum64     = '02d15c5fd1a1ed1abfa4e1412ad7eb727b728ad0e71b429c8ec1bedf2547b962'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
