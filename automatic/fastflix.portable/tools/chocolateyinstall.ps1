$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'FastFlix.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'FastFlix*'
  url64bit       = 'https://github.com/cdgriffith/FastFlix/releases/download/5.7.4/FastFlix_5.7.4_win64.zip'
  checksum64     = '79cd367052ded1f60c5abba672c513ae0d10ec00f18c0960cefd2dc510a7c4c7'
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
