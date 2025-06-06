$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Telegram.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Telegram*'
  url            = 'https://github.com/forkgram/tdesktop/releases/download/v5.15.2/Telegram_x86.zip'
  checksum       = '0368222867385bfaaf5380ff0982996f14e3d82d9dbf58a7629f6b9b2147c97a'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/forkgram/tdesktop/releases/download/v5.15.2/Telegram.zip'
  checksum64     = 'dd3cf8bde04875c9192716dededd99ab0a6e917ff536af92b40b82e332b32648'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
