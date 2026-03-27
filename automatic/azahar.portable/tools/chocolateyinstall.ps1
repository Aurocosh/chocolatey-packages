$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2125.0/azahar-windows-msvc-2125.0.zip'
  checksum64     = '7c9bd08ee53d19349623e261ed5a74880e2d89f34dce0861e0ed491382c1dd85'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exeFile = (Get-ChildItem "$packagePath/azahar-*-windows-msvc/azahar.exe" -File | Select-Object -First 1).FullName

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\azahar.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
