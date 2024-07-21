$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'EasyAutoClicker.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  url64bit       = 'https://sourceforge.net/projects/hf-auto-clicker/files/EasyAutoClicker.exe/download'
  checksum64     = 'fec496ca416e6e6096773d986e2d44147901e37e61ba5df86405efab22fa32a4'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\EasyAutoClicker.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\EasyAutoClicker.lnk" -TargetPath $exeFile -IconLocation $exeFile
