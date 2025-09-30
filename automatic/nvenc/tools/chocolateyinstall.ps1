$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/9.04/NVEncC_9.04_Win32.7z'
  checksum       = '23350e1d529f64daf9f3f555e3a5c3645f221b2d87c19f11ffa538ca56b8342c'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/9.04/NVEncC_9.04_x64.7z'
  checksum64     = '2765e73d2ac3aca892d8f29415468a7e4bab1be0f2a3ff4985e8e88364d92f66'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
