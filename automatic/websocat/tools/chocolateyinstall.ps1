$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'websocat.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'websocat*'
  url            = 'https://github.com/vi/websocat/releases/download/v1.14.2/websocat.i686-pc-windows-gnu.exe'
  checksum       = 'ce350ce3b3206eb90f847d2e3a7af193c943806637373746df0dc925f3b8f793'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/vi/websocat/releases/download/v1.14.2/websocat.x86_64-pc-windows-gnu.exe'
  checksum64     = '90797ce63356c5d2acb2e295c62642d8d28e86dd12908eaa5c3d254370036acd'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
