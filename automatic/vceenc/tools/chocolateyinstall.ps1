$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  url            = 'https://github.com/rigaya/VCEEnc/releases/download/9.14/VCEEncC_9.14_Win32.7z'
  checksum       = '0bcf4d2dcf1b975ac6e435ea5ffa569dc7b9580719fa28d53dd30187a36c79a3'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/9.14/VCEEncC_9.14_x64.7z'
  checksum64     = 'fe29a204f59334ff9789cd0de974d81ecc7aae9732442e7a79cc1c2803793764'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
