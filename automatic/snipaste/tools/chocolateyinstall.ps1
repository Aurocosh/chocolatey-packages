$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Snipaste.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Snipaste*'
  url            = 'https://dl.snipaste.com/win-x86-beta'
  checksum       = 'c80a47ffd7466a9230a42d8f2ac38ed9904f9104fccb419378fca80dd7a32287'
  checksumType   = 'sha256'
  url64bit       = 'https://dl.snipaste.com/win-x64-beta'
  checksum64     = 'dc4ed80407ad4c9f7b8130cfea089220504371ec6a51a1bab565758fe840b333'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Add Desktop shortcut
If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Snipaste.lnk" -TargetPath $exeFile
}

# Add StartMenu shortcut
If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Snipaste.lnk" -TargetPath $exeFile
}
