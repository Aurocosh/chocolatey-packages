$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  # url            = 'https://github.com/rigaya/NVEnc/releases/download/9.38/NVEncC_9.38_Win32.7z' # x86 temporarily disabled
  # checksum       = '5db7651070dc45002f9007bb42195b1cb1814b0564f5ea0b8e7caf1d4e33e25f' # x86 temporarily disabled
  # checksumType   = 'sha256' # x86 temporarily disabled
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/9.40/NVEncC_9.40_x64.7z'
  checksum64     = 'ce116f1145e336f66bc3196d0121d0684a28972ca0461becfd9ebe1873a74f41'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
