$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'OpenComic.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.4.1/OpenComic.Portable.1.4.1.exe'
  checksum64     = 'bdc0069725da3a2935039505cd6ffa24011a1aca8f2ef3458b468926dc5f94d0'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
