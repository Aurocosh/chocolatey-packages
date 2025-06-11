$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/7.90/QSVEncC_7.90_Win32.7z'
  checksum       = '2ca844a67c80087b9461f841ef1f942679df9f56596028da8f12e03d893feb41'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/7.90/QSVEncC_7.90_x64.7z'
  checksum64     = 'd5d0d896a8300ceb72f9a835d7b8c433ba2d85f158a2bf5c7f9cebc20afc97ba'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
