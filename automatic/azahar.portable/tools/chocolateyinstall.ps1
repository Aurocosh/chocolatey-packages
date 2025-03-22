$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2120/azahar-2120-windows-msvc.zip'
  checksum64     = '013ea3a389acc0731386db3c28558869a219941626a00536bbe0767578ffe166'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exeFile = (Get-ChildItem "$packagePath/azahar-*-windows-msvc/azahar.exe" -File | Select-Object -First 1).FullName

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
