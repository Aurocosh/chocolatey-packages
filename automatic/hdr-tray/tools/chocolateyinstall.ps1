$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'HDRTray.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'HDRTray*'
  url64bit       = 'https://github.com/res2k/HDRTray/releases/download/v0.5.5/HDRTray-v0.5.5.zip'
  checksum64     = '62de6da11bef91e2ca25e9eb6e818d25336970bbf1d864680dc58d7f656fc617'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\HDRTray.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\HDRTray.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
