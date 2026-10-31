$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  # url            = 'https://github.com/rigaya/QSVEnc/releases/download/8.34/QSVEncC_8.34_Win32.7z' # x86 temporarily disabled
  # checksum       = 'd0c3ce2ad7ced17e28cbd774503c31dc119ddbd81fcfaa5ce95b2fd3e62eb6da' # x86 temporarily disabled
  # checksumType   = 'sha256' # x86 temporarily disabled
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/8.36/QSVEncC_8.36_x64.7z'
  checksum64     = '3226b8d49bb976b8e14bf676fb1843456607da09b1944f8454d1f81586c8c474'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
