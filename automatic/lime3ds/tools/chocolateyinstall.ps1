$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2116/lime3ds-2116-windows-msvc.zip'
$checksum64msvc = '82713c691960d485a4605b61e3c97ea9b897d62b7c95f791d7710515d877c777'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2116/lime3ds-2116-windows-msys2.zip'
$checksum64msys2 = '4d7ce307165771e403bc8f1fdae57373030f949e4a133d0ecc42256857e543b9'

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
