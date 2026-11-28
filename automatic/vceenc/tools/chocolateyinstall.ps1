$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  # url            = 'https://github.com/rigaya/VCEEnc/releases/download/9.21/VCEEncC_9.21_Win32.7z' # x86 temporarily disabled
  # checksum       = 'fc7eb133e2975620515daca84650bb4f15e30dd2d6c005435f7d531001166d19' # x86 temporarily disabled
  # checksumType   = 'sha256' # x86 temporarily disabled
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/9.24/VCEEncC_9.24_x64.7z'
  checksum64     = 'ac822fad32eea50d78bbeaa84edca636c9dee6b29382d1a854eda3ae411f2262'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
