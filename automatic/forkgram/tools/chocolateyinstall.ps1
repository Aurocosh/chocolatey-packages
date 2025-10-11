$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Telegram.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Telegram*'
  url            = 'https://github.com/forkgram/tdesktop/releases/download/v6.2.0/Telegram_x86.zip'
  checksum       = '1a481e25970ba0ee48ecbaff2395078d78707b6d11ac0c811e2c27f25e904ebd'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/forkgram/tdesktop/releases/download/v6.2.0/Telegram.zip'
  checksum64     = 'f1328297422dd1ba6b1b654fa8f49c9cf082c2424b7b232d905340876a5909e9'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
