$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'XYPlorer.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $installPath
  softwareName    = 'XYPlorer*'
  url64bit        = 'https://www.xyplorer.com/free-zer/28.00/xyplorer64_full_noinstall.zip'
  checksum64      = '1c478bc9d34f684e7095196884809f4557fe77223fe6b51b6f429f63b44ecb7b'
  checksumType64  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\XYPlorer.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\XYPlorer.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}
