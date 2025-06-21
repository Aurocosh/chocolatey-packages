$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2122.1/azahar-2122.1-windows-msvc.zip'
  checksum64     = '2b168a2c1f3973b64e945a0f7341d97badddcab5e85600c476b18b21b31a40ee'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exeFile = (Get-ChildItem "$packagePath/azahar-*-windows-msvc/azahar.exe" -File | Select-Object -First 1).FullName

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
