
$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Tagscan.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Tagscan*'
  url            = 'https://www.xdlab.ru/files/tagscan-6.1.21.zip'
  checksum       = 'b542a10e358877ef19be2a72f3a7bfde7d4daefb7c3f00ce13b71f324f2edf37'
  checksumType   = 'sha256'
  url64bit       = 'https://www.xdlab.ru/files/tagscan-6.1.21_x64.zip'
  checksum64     = 'e71b537f55eadf8add4f2e369e19ea2cea63e60af5667d9725121dad390474fe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Tagscan.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Tagscan.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
