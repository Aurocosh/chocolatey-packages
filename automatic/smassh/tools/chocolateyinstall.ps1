$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'smassh.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'smassh*'
  url64bit       = 'https://github.com/kraanzu/smassh/releases/download/v3.2.1/windows-smassh.exe'
  checksum64     = '36c29a75ae17d11609d7c0f2d5f7d85ad2f828feff9a89a7075b9daa929bed6a'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\smassh.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\smassh.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
