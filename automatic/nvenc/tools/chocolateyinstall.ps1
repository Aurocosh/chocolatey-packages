$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/9.03/NVEncC_9.03_Win32.7z'
  checksum       = 'e4bf16e244ce4de4dbe9df341b0ded6953d2f3e77da717525e61b03f1a1710a1'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/9.03/NVEncC_9.03_x64.7z'
  checksum64     = '1d941ced7c73710df3ce5287711bbea6330deb3bdee7c2e2080ac9b68e0c3350'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
