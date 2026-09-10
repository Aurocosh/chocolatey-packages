$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2126.1/azahar-windows-msvc-2126.1.zip'
  checksum64     = '7f485a89bb2ebce9b1a808f7682e7f591c5c2845d981ed0b2c132e21f3a92645'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exeFile = (Get-ChildItem "$packagePath/azahar-windows-msvc-*/azahar.exe" -File | Select-Object -First 1).FullName

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
