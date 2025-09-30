$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/8.01/QSVEncC_8.01_Win32.7z'
  checksum       = '299fa2c7e44ac9e3c8ceace40a382852c052ae87c6a16d4c626beb53460ec11a'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/8.01/QSVEncC_8.01_x64.7z'
  checksum64     = '6a172f336ea82d68220c259713478b191544e305a492c88e6b1517a564122de3'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
