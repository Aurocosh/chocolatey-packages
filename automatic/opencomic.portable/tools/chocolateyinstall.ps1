$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'OpenComic.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.1/OpenComic.Portable.1.6.1.exe'
  checksum64     = 'fb1b704f6659b1ac16415da2edbd3a83413b882fa34ccd53361affcfe642ed78'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
