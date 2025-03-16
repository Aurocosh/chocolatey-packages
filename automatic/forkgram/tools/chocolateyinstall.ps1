$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Telegram.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Telegram*'
  url            = 'https://github.com/forkgram/tdesktop/releases/download/v5.12.5/Telegram_x86.zip'
  checksum       = '0b5c620f1a177eac1afa26f0b17406b875e7aa4220cdf58868517c00c63a5a68'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/forkgram/tdesktop/releases/download/v5.12.5/Telegram.zip'
  checksum64     = 'ca4214ad0b44ceadb6f4facfd6ea761ac32c645ce4ce385265ba543fe1123b44'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Telegram.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
