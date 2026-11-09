$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'trilium.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'trilium*'
  url64bit       = 'https://github.com/TriliumNext/Trilium/releases/download/v0.107.0/TriliumNotes-v0.107.0-windows-x64.zip'
  checksum64     = 'f79d9e063a68c783206132e7845d9b2801c9e1da7c9fba78ea9cdcf57477613c'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
