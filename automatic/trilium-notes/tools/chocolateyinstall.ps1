$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'trilium.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'trilium*'
  url64bit       = 'https://github.com/TriliumNext/Trilium/releases/download/v0.105.0/TriliumNotes-v0.105.0-windows-x64.zip'
  checksum64     = '100cf02bfa08b85d00b182396e9ac5b8f53ea6d9a5e86552d3168e77f88237c9'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
