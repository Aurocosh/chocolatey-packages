$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile = Join-Path $toolsDir 'OpenComic.exe'

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileFullPath = $exeFile
  url          = 'https://github.com/ollm/OpenComic/releases/download/v1.0.0/OpenComic.Portable.1.0.0.exe'
  checksum     = 'F179905B0D3D38820AAF1E35935812974C2FD39D678CC3A10F105EB741E2C989'
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\OpenComic.lnk" -TargetPath $exeFile -IconLocation $exeFile