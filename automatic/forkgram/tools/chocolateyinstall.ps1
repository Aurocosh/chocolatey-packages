$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Telegram.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Telegram*'
  url            = 'https://github.com/forkgram/tdesktop/releases/download/v7.2.8/Telegram_x86.zip'
  checksum       = '59aee55a9a222e89a336010c6bc7ece9b6f45f95f9b6a57af4115073b6611759'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/forkgram/tdesktop/releases/download/v7.2.8/Telegram.zip'
  checksum64     = 'b29a306eaf49288fa39fc1116672d7ffe7904cd86c1910a1a32f6f8c3954aa2a'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
