$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'ABDownloadManager'
$exeFile = Join-Path $installPath 'ABDownloadManager.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.8.4/ABDownloadManager_1.8.4_windows_x64.zip'
  checksum64     = '00cc25a1c61406d2a3ec5a11bb3cb477d82c7f20e41b74709cb244e48c0a1a11'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
