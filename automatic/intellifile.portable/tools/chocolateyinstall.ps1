$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'IntelliFile'
$exeFile = Join-Path $installPath 'IntelliFile.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'IntelliFile*'
  url64bit       = 'https://github.com/mihaimoga/IntelliFile/releases/download/v1.46/IntelliFile.zip'
  checksum64     = '486bf9a3f1e9c035695c02308d9ab2a4236695ee70d496066d71303d996776c8'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\IntelliFile.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\IntelliFile.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}
