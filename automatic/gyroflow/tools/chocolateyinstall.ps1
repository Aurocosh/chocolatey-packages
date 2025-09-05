$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Gyroflow.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Gyroflow*'
  url64bit       = 'https://github.com/gyroflow/gyroflow/releases/download/v1.6.3/Gyroflow-windows64.zip'
  checksum64     = '37ef4064adb6991ae2251e283e5888a02ea00024d0a6f1353501892bb5367e21'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
