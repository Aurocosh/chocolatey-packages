$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/8.33/QSVEncC_8.33_Win32.7z'
  checksum       = '99974d0aec82d4ddaef61c7b5cc1be83f551cfbd5bbf7fb82964587ad0e358dd'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/8.33/QSVEncC_8.33_x64.7z'
  checksum64     = '358dafb3188b712db9e58fb47cdf0dd75ebbdb1c08af3f19eb54157da9bbd9c7'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
