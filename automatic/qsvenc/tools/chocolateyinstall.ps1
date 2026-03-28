$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/8.07/QSVEncC_8.07_Win32.7z'
  checksum       = 'c2b51ab1ec7e8f45dfd80604ccafeb0d673dc8fd4cc8fa940382f92884a3912f'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/8.07/QSVEncC_8.07_x64.7z'
  checksum64     = '3e9f1fe44ae3e37ac13677e80d96ecadbeb6278f0c7528793c0020373b2cd93f'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
