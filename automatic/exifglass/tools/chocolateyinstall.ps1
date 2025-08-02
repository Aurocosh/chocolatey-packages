$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ExifGlass*'
  url64bit       = 'https://github.com/d2phap/ExifGlass/releases/download/1.9.0.0/ExifGlass_1.9.0.0_x64.zip'
  checksum64     = '11de3afe01a30b07bda14041ad65ba09aead1cabcef7e75466083881f236ed6e'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installPath = (Get-ChildItem $packagePath -filter "ExifGlass_*" -Directory | Select-Object -First 1).FullName
$exeFile = Join-Path $installPath 'ExifGlass.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath

New-Item (Join-Path $installPath 'exiftool.exe.ignore') -type File
