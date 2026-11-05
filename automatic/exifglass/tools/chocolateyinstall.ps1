$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ExifGlass*'
  url64bit       = 'https://github.com/d2phap/ExifGlass/releases/download/3.0.0.1105/ExifGlass_3.0.0.1105_win-x64.zip'
  checksum64     = 'b1047a62696a308c0ffa690a4a9866c354d94cb19ab7a5b70fedd7a3e2e54ce9'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installPath = (Get-ChildItem $packagePath -filter "ExifGlass_*" -Directory | Select-Object -First 1).FullName
$exeFile = Join-Path $installPath 'ExifGlass.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath

New-Item (Join-Path $installPath 'exiftool.exe.ignore') -type File
