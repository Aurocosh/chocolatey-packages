$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2117/lime3ds-2117-windows-msvc.zip'
$checksum64msvc = '1bd02c7bea5d8ea0f9bd915cc08404f8e2f8e1bb6f7d4c60c1c6b4675b1bbcfe'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2117/lime3ds-2117-windows-msys2.zip'
$checksum64msys2 = '9a91e2837c81118d7528400c261c5f3022c08886a5ec54211beda6a1edcbc2b6'

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
