$installPath = Join-Path (Get-ToolsLocation) 'snipaste'
$exeFile = Join-Path $installPath 'Snipaste.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Snipaste*'
  checksumType   = 'sha256'
  url64bit       = 'https://download.snipaste.com/archives/Snipaste-2.10.8-x64.zip'
  checksum64     = 'f134dd315ee7f7726fa4dbcc93baa5ab01429f3b9e169d84d9e2acdd775d2965'
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
