$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'IntelliFile'
$exeFile = Join-Path $installPath 'IntelliFile.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'IntelliFile*'
  url64bit       = 'https://github.com/mihaimoga/IntelliFile/releases/download/v1.36/IntelliFile.zip'
  checksum64     = '4eb6789f18b90a4bf2253980fa7b6b5eed0a695b62a58b6943ca42ca1e48b8a3'
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
