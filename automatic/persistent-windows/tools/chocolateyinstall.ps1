$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PersistentWindows.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'PersistentWindows*'
  url            = 'https://github.com/kangyu-california/PersistentWindows/releases/download/5.67/PersistentWindows5.67.zip'
  checksum       = 'a9c75525e73b035cc98fbf8054a252598a271bb68a3e548e364b2cf6b4903455'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PersistentWindows.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
