$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'HDRTray.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'HDRTray*'
  url64bit       = 'https://github.com/res2k/HDRTray/releases/download/v0.5.4/HDRTray-v0.5.4.zip'
  checksum64     = '637a1a1a7db792beaf2665e4f8a09e315e9129c2f37847e06b6b9ad1d3885757'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\HDRTray.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\HDRTray.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
