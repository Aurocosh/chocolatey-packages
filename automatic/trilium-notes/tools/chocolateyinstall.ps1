$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'trilium.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'trilium*'
  url64bit       = 'https://github.com/TriliumNext/Trilium/releases/download/v0.106.1/TriliumNotes-v0.106.1-windows-x64.zip'
  checksum64     = '9f1b4b2658e806b0bc57a4932569effd88e6316c29ae9d2034181650aab059d0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
