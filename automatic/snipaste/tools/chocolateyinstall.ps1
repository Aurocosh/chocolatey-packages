$installPath = Join-Path (Get-ToolsLocation) 'snipaste'
$exeFile = Join-Path $installPath 'Snipaste.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Snipaste*'
  checksumType   = 'sha256'
  url64bit       = 'https://api.bitbucket.org/2.0/repositories/liule/snipaste/downloads/Snipaste-2.10.5-x64.zip'
  checksum64     = '88ab0b43f5bb6a3df0beca82cafec8b631dac75de6fa7a3c62e09cd7e7e8bd52'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
icacls $installPath /grant "Authenticated Users:(OI)(CI)(M)"

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Snipaste.lnk" -TargetPath $exeFile
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Snipaste.lnk" -TargetPath $exeFile
}
