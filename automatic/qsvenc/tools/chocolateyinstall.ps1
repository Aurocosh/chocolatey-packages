$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/7.86/QSVEncC_7.86_Win32.7z'
  checksum       = '5a1531035bdb44c6166468c0d7062417df6f746ce763ba5a46dd7958bb18dacc'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/7.86/QSVEncC_7.86_x64.7z'
  checksum64     = '1307c2c2f6f18e1ae902bb35c574e81485933314b86866ec759fe0999e7cd3d9'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
