$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'ABDownloadManager'
$exeFile = Join-Path $installPath 'ABDownloadManager.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.6.2/ABDownloadManager_1.6.2_windows_x64.zip'
  checksum64     = '6b8f84df1e934ca4e9c12f4526b1a5d8712cd7791bedc26c64b36673a0ba6cb1'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
