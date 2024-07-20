$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Houdoku.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  url64bit       = 'https://github.com/xgi/houdoku/releases/download/v2.14.0/Houdoku-2.14.0-win.zip'
  softwareName   = 'houdoku*'
  checksum64     = '9466645245a5591ec60200be48af9c83c9997f76db8f5d26c27ffb525fba2d31'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# $packageArgs.file = Join-Path -Path $toolsDir -ChildPath $installerName
# Install-ChocolateyInstallPackage @packageArgs

# Remove-Item "$toolsDir/$installerName"

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Houdoku.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Houdoku.lnk" -TargetPath $exeFile -IconLocation $exeFile
