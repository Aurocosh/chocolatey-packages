$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'PixiEditor'
$exeFile = Join-Path $installPath 'PixiEditor.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'PixiEditor*'
  url64bit       = 'https://github.com/PixiEditor/PixiEditor/releases/download/2.1.1.5/PixiEditor.2.1.1.5.x64-win.zip'
  checksum64     = '6215525f87f14c8e83da7aa73e6039da1c0bb2fe2e8a226696ca3c0438222ab2'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PixiEditor.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PixiEditor.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath

New-Item (Join-Path $installPath '\ThirdParty\Windows\ffmpeg\ffmpeg.exe.ignore') -type File
