$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'OpenComic.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.4.0/OpenComic.Portable.1.4.0.exe'
  checksum64     = '0974db290649a9fe8692becdb43a6f5f1a495b3a3fbb977c97dea1f35a8ea292'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
