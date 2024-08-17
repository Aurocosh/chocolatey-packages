$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2117.1/lime3ds-2117.1-windows-msvc.zip'
$checksum64msvc = '9a11dc62d6d577bf09d7fd02db064aee1f26bcc553ef0a7f079c517eb303d6f5'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2117.1/lime3ds-2117.1-windows-msys2.zip'
$checksum64msys2 = '3148d229bf81177ce55b81e73ce43fe7a37fa442b9435df207c47c671c650e1e'

$PackageParameters = Get-PackageParameters

if ($PackageParameters.MsysVersion) {
  $url64 = $url64msys2
  $checksum64 = $checksum64msys2
}
else {
  $url64 = $url64msvc
  $checksum64 = $checksum64msvc
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'Lime3DS*'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$appFolder = (Get-ChildItem $packagePath -filter "lime3ds-*-windows-*" -Directory | Select-Object -First 1).FullName
$exeFile = Join-Path $appFolder 'lime3ds-gui.exe'

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Lime3DS.lnk" -TargetPath $exeFile
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lime3DS.lnk" -TargetPath $exeFile
}
