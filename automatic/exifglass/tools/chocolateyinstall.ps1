$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'ExifGlass*'
  url64bit       = 'https://github.com/d2phap/ExifGlass/releases/download/1.10.0.0/ExifGlass_1.10.0.0_x64.zip'
  checksum64     = 'ab3f1925640ac5cc150ecf366139565abff06323bfdc53a8e3c34c94adf5fff4'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installPath = (Get-ChildItem $packagePath -filter "ExifGlass_*" -Directory | Select-Object -First 1).FullName
$exeFile = Join-Path $installPath 'ExifGlass.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ExifGlass.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath

New-Item (Join-Path $installPath 'exiftool.exe.ignore') -type File
