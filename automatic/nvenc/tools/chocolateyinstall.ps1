$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/7.67/NVEncC_7.67_Win32.7z'
  checksum32     = '643d447707b0a2cd024f6a694b01f7a762f353a6b9c746ea3d41674050dd3fec'
  checksumType32 = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/7.67/NVEncC_7.67_x64.7z'
  checksum64     = '26278ec1c081c8342666aeffe86f6f1cc0e665999b75b6e55b51e486902deb57'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
