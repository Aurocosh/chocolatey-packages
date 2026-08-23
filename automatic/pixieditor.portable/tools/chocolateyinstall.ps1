$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'PixiEditor'
$exeFile = Join-Path $installPath 'PixiEditor.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'PixiEditor*'
  url64bit       = 'https://github.com/PixiEditor/PixiEditor/releases/download/2.1.2.2/PixiEditor.2.1.2.2.x64-win.zip'
  checksum64     = '15b8c8b57df16fcd759e54bb836cffa3dfb1a2228992ca445023a5b4c1a5e77d'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PixiEditor.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PixiEditor.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath

New-Item (Join-Path $installPath '\ThirdParty\Windows\ffmpeg\ffmpeg.exe.ignore') -type File
