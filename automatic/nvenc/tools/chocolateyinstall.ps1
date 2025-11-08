$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/9.07/NVEncC_9.07_Win32.7z'
  checksum       = '226aa229b8f5a1cde7f0d9a6f99a2797a4f202a59e572b2ea2e1bb6d8784e5b8'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/9.07/NVEncC_9.07_x64.7z'
  checksum64     = 'e50ade48623164bbc94b101d7db9e84dbd29011e327bdfaabd50d036bc6a7c87'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
