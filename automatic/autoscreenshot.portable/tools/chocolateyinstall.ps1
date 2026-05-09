$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'AutoScreenshot.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AutoScreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.22.1/AutoScreenshot_v1.22.1_Windows_x86_portable.zip'
  checksum       = '53d7d8a545533c423a10b95c9873a623adb5c080cb6a0b7ae15a6c5125f955eb'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.22.1/AutoScreenshot_v1.22.1_Windows_x64_portable.zip'
  checksum64     = '0756216da2252106a8c39c395f126f5fdce34e9881e4c85fe7799d2db55e0538'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFolder = (Get-ChildItem $packagePath -filter "AutoScreenshot_v*" -Directory | Select-Object -First 1).Name
$installPath = Join-Path $packagePath $installFolder
$exeFile = Join-Path $installPath 'AutoScreenshot.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
