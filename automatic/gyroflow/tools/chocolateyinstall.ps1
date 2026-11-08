$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Gyroflow.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Gyroflow*'
  url64bit       = 'https://github.com/gyroflow/gyroflow/releases/download/v1.7.0/Gyroflow-windows64.zip'
  checksum64     = '04c044c17bf3f5b20172fd12a709ac95ce99aa1e01c247687c12d158677df916'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
