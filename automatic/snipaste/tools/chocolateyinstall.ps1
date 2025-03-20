$installPath = Join-Path (Get-ToolsLocation) 'snipaste'
$exeFile = Join-Path $installPath 'Snipaste.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Snipaste*'
  checksumType   = 'sha256'
  url64bit       = 'https://api.bitbucket.org/2.0/repositories/liule/snipaste/downloads/Snipaste-2.10.6-x64.zip'
  checksum64     = 'b47d2b10d2c6ec05b1118cdd67bc86f77d2f63e6b23c07d70a1d3d4913d4dc22'
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
