$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'lan-mouse.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'lan-mouse*'
  url64bit       = 'https://github.com/feschber/lan-mouse/releases/download/v0.9.1/lan-mouse-windows.zip'
  checksum64     = '099f9bb2a3c61ed00a8df04e02dab765e67a929e814dab92f18b0c6cca76d6ba'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$toolsPath = Join-Path $packagePath 'tools'
$iconPath = Join-Path $toolsPath 'lan-mouse.ico'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Lan Mouse.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath -IconLocation $iconPath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lan Mouse.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath -IconLocation $iconPath
