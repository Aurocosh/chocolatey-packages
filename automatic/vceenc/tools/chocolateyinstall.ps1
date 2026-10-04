$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  url            = 'https://github.com/rigaya/VCEEnc/releases/download/9.21/VCEEncC_9.21_Win32.7z'
  checksum       = 'fc7eb133e2975620515daca84650bb4f15e30dd2d6c005435f7d531001166d19'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/9.21/VCEEncC_9.21_x64.7z'
  checksum64     = 'aa4a36d161cbe3073ed97d97ba5651c7579455ae60e173e5117d55f96afb8a19'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
