$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'lan-mouse.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'lan-mouse*'
  url64bit       = 'https://github.com/feschber/lan-mouse/releases/download/v0.11.0/lan-mouse-windows-x86_64.zip'
  checksum64     = 'f94f4e9bc6e64c5f97f497e6491f3cf478c80f2b2a3e13d88ea18cea581c06a0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$toolsPath = Join-Path $packagePath 'tools'
$iconPath = Join-Path $toolsPath 'lan-mouse.ico'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Lan Mouse.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath -IconLocation $iconPath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lan Mouse.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath -IconLocation $iconPath
