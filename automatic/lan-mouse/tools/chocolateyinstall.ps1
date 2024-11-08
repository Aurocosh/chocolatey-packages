$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'lan-mouse.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'lan-mouse*'
  url64bit       = 'https://github.com/feschber/lan-mouse/releases/download/v0.10.0/lan-mouse-windows.zip'
  checksum64     = '66b45ae67ebfac4eb32c61c3f4ac46814519437aa051156ae9e0a9db4737b170'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$toolsPath = Join-Path $packagePath 'tools'
$iconPath = Join-Path $toolsPath 'lan-mouse.ico'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Lan Mouse.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath -IconLocation $iconPath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lan Mouse.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath -IconLocation $iconPath
