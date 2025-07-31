$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/8.10/NVEncC_8.10_Win32.7z'
  checksum       = '1aaf87e451acf94c12951692f9cc47a9efdefaa5475795c46c00be441cc2c140'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/8.10/NVEncC_8.10_x64.7z'
  checksum64     = '5836e1b3df4a4d33f6682fa67b2ce0d1ecc691ebfa52cbf72afb8010d6167282'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
