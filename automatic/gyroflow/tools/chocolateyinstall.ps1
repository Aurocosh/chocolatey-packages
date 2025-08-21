$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Gyroflow.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Gyroflow*'
  url64bit       = 'https://github.com/gyroflow/gyroflow/releases/download/v1.6.2/Gyroflow-windows64.zip'
  checksum64     = '785e5593e37f30a7b4ffb8722c88c642b9109cf106a552326cfdbafe22474666'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Gyroflow.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
