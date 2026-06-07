$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/8.15/QSVEncC_8.15_Win32.7z'
  checksum       = '16d9f520d822d1d5399691547cdc23dbe99204113f3c903fcdab81c2e6935359'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/8.15/QSVEncC_8.15_x64.7z'
  checksum64     = 'b71e0bee4310f633ea258bd802b11b9fd20ff45121c63f2bc9b10b66b3b46187'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
