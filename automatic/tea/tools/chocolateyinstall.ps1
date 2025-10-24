$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.9.2/tea-0.9.2-windows-amd64.exe'
  checksum64     = '7DBBF98468BC829D26D887058F41EA4505CFDF9C7BFFAA6495AAA30B6FE866B1'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
