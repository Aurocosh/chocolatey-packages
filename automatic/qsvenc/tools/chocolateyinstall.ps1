$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/7.91/QSVEncC_7.91_Win32.7z'
  checksum       = 'cd75a58a1fb5c1cc2a569c20d2718bb1bb0da02dae377d3c9c7b05bf9117220b'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/7.91/QSVEncC_7.91_x64.7z'
  checksum64     = '586eeee358a2352312374711ed63e7ef84ac8facd964e680391f164a6710b6ef'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
