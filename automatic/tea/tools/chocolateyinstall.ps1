$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'tea.exe'

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'tea*'
  url64bit       = 'https://gitea.com/gitea/tea/releases/download/v0.12.0/tea-0.12.0-windows-amd64.exe'
  checksum64     = 'e94483860b546eaa0558755165030efc76798588d972cad916a99bdbe101cc02'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
