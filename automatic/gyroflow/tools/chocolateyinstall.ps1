$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Gyroflow.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Gyroflow*'
  url64bit       = 'https://github.com/gyroflow/gyroflow/releases/download/v1.6.1/Gyroflow-windows64.zip'
  checksum64     = '3b32b7c946d32e68e3381573478042b4522f7a82ca0778e7088d6a91b7c2d7ef'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
