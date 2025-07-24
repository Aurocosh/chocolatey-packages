$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PersistentWindows.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'PersistentWindows*'
  url            = 'https://github.com/kangyu-california/PersistentWindows/releases/download/5.69/PersistentWindows5.69.zip'
  checksum       = '9b5ca4ee0d2825a8da287c39445db223565f5af305f1c73d2fe14e0b061ac36b'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
