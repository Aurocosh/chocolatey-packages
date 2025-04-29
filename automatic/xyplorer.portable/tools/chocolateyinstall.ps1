$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'XYPlorer.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installPath
  softwareName  = 'XYPlorer*'
  url           = 'https://www.xyplorer.com/free-zer/27.00/xyplorer_full_noinstall.zip'
  checksum      = 'd95f5f1b8da11360f752203c60ea9f47cc440c10772df37f6e45501493f867f4'
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
