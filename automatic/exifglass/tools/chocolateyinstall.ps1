$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ExifGlass*'
  url64bit       = 'https://github.com/d2phap/ExifGlass/releases/download/2.0.0.0/ExifGlass_2.0.0.0_win-x64.zip'
  checksum64     = 'a17e84901b0c188ba7d56ed053794bbdb19647cb1d72ca609a9d27335ca88201'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installPath = (Get-ChildItem $packagePath -filter "ExifGlass_*" -Directory | Select-Object -First 1).FullName
$exeFile = Join-Path $installPath 'ExifGlass.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath

New-Item (Join-Path $installPath 'exiftool.exe.ignore') -type File
