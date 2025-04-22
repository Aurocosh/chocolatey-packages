$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/7.87/QSVEncC_7.87_Win32.7z'
  checksum       = 'ef7c4d176b34e1b89f93ddfae1f3a38d544c1c8c470918929e5edc82a2417ddb'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/7.87/QSVEncC_7.87_x64.7z'
  checksum64     = 'cb1fb6a087caeb86d9699a79e13fd868bdc343ceadcfebbe816bbfb875986ca1'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
