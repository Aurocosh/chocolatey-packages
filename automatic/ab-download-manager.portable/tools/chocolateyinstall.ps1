$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'ABDownloadManager'
$exeFile = Join-Path $installPath 'ABDownloadManager.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.5.4/ABDownloadManager_1.5.4_windows_x64.zip'
  checksum64     = 'cbc584a826b8a5558bf183fbc9521c5e524e3b6108e4b10e72cd9b9113d4dbc2'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
