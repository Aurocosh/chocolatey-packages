$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'FastFlix.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'FastFlix*'
  url64bit       = 'https://github.com/cdgriffith/FastFlix/releases/download/5.12.4/FastFlix_5.12.4_win64.zip'
  checksum64     = 'ce37eba8dd99cc6ab07651ebf75376cfd92f79461193886ed1b6edd6004bc996'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\FastFlix.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\FastFlix.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}
