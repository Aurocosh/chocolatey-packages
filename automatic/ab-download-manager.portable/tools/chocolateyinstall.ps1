$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'ABDownloadManager'
$exeFile = Join-Path $installPath 'ABDownloadManager.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.8.3/ABDownloadManager_1.8.3_windows_x64.zip'
  checksum64     = '7b8a3ead0a566021e710ff32990c7e1e18fb51ad8a0b091cfc6c15a46522eefe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AB Download Manager.lnk" -TargetPath $exeFile -IconLocation $exeFile
