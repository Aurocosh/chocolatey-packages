$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2124.3/azahar-2124.3-windows-msvc.zip'
  checksum64     = '3aec840451cb5c9d800336abe2bc2aa5114f24fc06cf95182e2d1765242d20fc'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exeFile = (Get-ChildItem "$packagePath/azahar-*-windows-msvc/azahar.exe" -File | Select-Object -First 1).FullName

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
