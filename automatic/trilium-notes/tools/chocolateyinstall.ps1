$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'trilium.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'trilium*'
  url64bit       = 'https://github.com/TriliumNext/Trilium/releases/download/v0.106.0/TriliumNotes-v0.106.0-windows-x64.zip'
  checksum64     = '15dd7b746c682b4e00b44e8ccb44571ace38f8f918323b3ae929732010e959d8'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
