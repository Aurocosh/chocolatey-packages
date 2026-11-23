$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Gyroflow.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Gyroflow*'
  url64bit       = 'https://github.com/gyroflow/gyroflow/releases/download/v1.7.1/Gyroflow-windows64.zip'
  checksum64     = 'e882319e0455c452dd7c4dd69433d32bfd8271ba20fcf7f01ec9af669487b3d9'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
