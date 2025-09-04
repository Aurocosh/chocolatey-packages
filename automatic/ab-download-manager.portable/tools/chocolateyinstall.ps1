$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'ABDownloadManager'
$exeFile = Join-Path $installPath 'ABDownloadManager.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.6.11/ABDownloadManager_1.6.11_windows_x64.zip'
  checksum64     = 'bb476237cf6db10109dfc712c512fb7e7dccafa1e43c12798ba5131b0643c5c0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
