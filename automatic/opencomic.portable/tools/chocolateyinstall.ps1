$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'OpenComic.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.5/OpenComic.Portable.1.6.5.exe'
  checksum64     = '4d45f93acf17ee595dbef9612ca0a98acfc268cf0e7cd0c9c067b6085e7abda1'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
