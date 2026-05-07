$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PersistentWindows.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'PersistentWindows*'
  url            = 'https://github.com/kangyu-california/PersistentWindows/releases/download/5.76/PersistentWindows5.76.zip'
  checksum       = 'bbf8ed2eb3e662d6f9dc35b85047ad52bd4c793afcf1951afd0c9599c7403c79'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
