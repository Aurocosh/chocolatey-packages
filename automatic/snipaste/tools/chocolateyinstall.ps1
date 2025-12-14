$installPath = Join-Path (Get-ToolsLocation) 'snipaste'
$exeFile = Join-Path $installPath 'Snipaste.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Snipaste*'
  checksumType   = 'sha256'
  url64bit       = 'https://download.snipaste.com/archives/Snipaste-2.11.2-x64.zip'
  checksum64     = '594a32928e88b365b95560a68c2ca43a43dcfeb3c3429fe990da26c90749bbd8'
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
