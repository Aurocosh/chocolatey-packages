$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Houdoku.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'houdoku*'
  url64bit       = 'https://github.com/xgi/houdoku/releases/download/v2.15.0/Houdoku-2.15.0-win.zip'
  checksum64     = 'af6bce5ea2cdae6aaf1e84a4d57ebf22db856936dc0794f980e66fb4929ca591'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Houdoku.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Houdoku.lnk" -TargetPath $exeFile -IconLocation $exeFile
