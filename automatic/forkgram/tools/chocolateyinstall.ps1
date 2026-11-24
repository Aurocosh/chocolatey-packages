$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Telegram.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Telegram*'
  url            = 'https://github.com/forkgram/tdesktop/releases/download/v7.4.6/Telegram_x86.zip'
  checksum       = 'ae686abd30efdfd0f865eff43ebd1be98bc30a8b61a843e693c919770d8292c5'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/forkgram/tdesktop/releases/download/v7.4.6/Telegram.zip'
  checksum64     = 'cdc767951607a809915ac8cd85ad7782af682af353ab698dcdcb35fe2afd4b53'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
