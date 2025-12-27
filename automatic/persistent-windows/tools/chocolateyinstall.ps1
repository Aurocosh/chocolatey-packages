$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PersistentWindows.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'PersistentWindows*'
  url            = 'https://github.com/kangyu-california/PersistentWindows/releases/download/5.72/PersistentWindows5.72.zip'
  checksum       = 'a0e19b3f55ccab3ee200c9e74222b254ac9e22c96270bef797ec9187f25df6bc'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
