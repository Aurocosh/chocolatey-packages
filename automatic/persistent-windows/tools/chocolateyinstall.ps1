$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PersistentWindows.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'PersistentWindows*'
  url            = 'https://github.com/kangyu-california/PersistentWindows/releases/download/5.75/PersistentWindows5.75.zip'
  checksum       = '85c78f1fc151118a0ace4fa092c863b5a030f127db5363ad49d46da69fefc855'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
