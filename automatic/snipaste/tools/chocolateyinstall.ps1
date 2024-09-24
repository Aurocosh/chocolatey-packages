$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Snipaste.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Snipaste*'
  url            = 'https://dl.snipaste.com/win-x86'
  checksum       = '1fb26a222976f91f750ac96cbeb9bac86247ffd78ea6dcbceca9980e09c78c46'
  checksumType   = 'sha256'
  url64bit       = 'https://dl.snipaste.com/win-x64'
  checksum64     = 'd9d6c36c961a7f91c7fc1cc511ef55b89ca6ab073e4bc2b3548a0fa9c8423080'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Snipaste.lnk" -TargetPath $exeFile
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Snipaste.lnk" -TargetPath $exeFile
}
