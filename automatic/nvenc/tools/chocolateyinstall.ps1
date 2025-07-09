$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/8.08/NVEncC_8.08_Win32.7z'
  checksum       = '39f7ee697393654e2d06b2418960c783cd87f3a7a8f595788ef8f7e6a8d26f6d'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/8.08/NVEncC_8.08_x64.7z'
  checksum64     = '6ca70e0a5e322212c2d8ceecb17d045d8eeb81ecb5e16bffdf52fa31cb9e8bab'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
