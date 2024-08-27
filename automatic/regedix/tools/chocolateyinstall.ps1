$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'Regedix.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'Regedix*'
  url            = 'https://regedix.webrox.fr/download.php?v=2.0.0.0&file=2.0.0.0/Regedix-2.0.0-x86.exe'
  checksum       = '97851ba0c378a95b8a2daedea6229579ba85798a2561dd2bd285d939a41b452b'
  checksumType   = 'sha256'
  url64bit       = 'https://regedix.webrox.fr/download.php?v=2.0.0.0&file=2.0.0.0/Regedix-2.0.0-x64.exe'
  checksum64     = '25711db7e9b7396ac535894439ab9c2517a713e65d5cf56204f717d94039c74c'
  checksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Regedix.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Regedix.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}