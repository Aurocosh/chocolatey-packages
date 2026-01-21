$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'trilium.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'trilium*'
  url64bit       = 'https://github.com/TriliumNext/Trilium/releases/download/v0.101.3/TriliumNotes-v0.101.3-windows-x64.zip'
  checksum64     = 'ae052d4fccd1b79ef8d20e697b9eca55c70778627fda6d6891cf1021e9d51ffb'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\trilium.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
