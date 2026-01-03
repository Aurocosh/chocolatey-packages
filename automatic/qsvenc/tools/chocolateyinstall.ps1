$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/8.04/QSVEncC_8.04_Win32.7z'
  checksum       = '553449ae1cb1b2db353a851d0474a4e8597837fb3c8c656a90b1ff401bb6c4ec'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/8.04/QSVEncC_8.04_x64.7z'
  checksum64     = 'd63d9ca6c8d9b0cdeddde9c2bd99660f52e97ff1766baf5a18d0f8cd3cd0dbfe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
