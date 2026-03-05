$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'XYPlorer.exe'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $installPath
  softwareName    = 'XYPlorer*'
  url             = 'https://www.xyplorer.com/free-zer/27.20/xyplorer_full_noinstall.zip'
  checksum        = 'b2262e65e9f7f1c229ab79dad675b63d519d782f82d0db4bfdf2d887bf51a4f3'
  checksumType    = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\XYPlorer.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\XYPlorer.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}
