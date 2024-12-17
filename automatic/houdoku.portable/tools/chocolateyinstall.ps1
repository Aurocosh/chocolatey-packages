$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Houdoku.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'houdoku*'
  url64bit       = 'https://github.com/xgi/houdoku/releases/download/v2.16.0/Houdoku-2.16.0-win.zip'
  checksum64     = 'f7791f1af7b6dd2df938cd4e919eb5311fbd04fcf857a8bfe5374ae0170f945a'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Houdoku.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Houdoku.lnk" -TargetPath $exeFile -IconLocation $exeFile
