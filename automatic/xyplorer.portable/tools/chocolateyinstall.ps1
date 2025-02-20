$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'XYPlorer.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installPath
  softwareName  = 'XYPlorer*'
  url           = 'https://www.xyplorer.com/free-zer/26.90/xyplorer_full_noinstall.zip'
  checksum      = '40d825ea42bb6b74dedc8eeaf02e08a9ee7d1a947316a49754f535d9dc294b20'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\XYPlorer.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\XYPlorer.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}
