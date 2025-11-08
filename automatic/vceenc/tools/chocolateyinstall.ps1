$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  url            = 'https://github.com/rigaya/VCEEnc/releases/download/9.02/VCEEncC_9.02_Win32.7z'
  checksum       = '5445f298f184e5098c3cd511348566f1a6a9da4ba8f8ce5e6e2e7bd1c9dae39a'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/9.02/VCEEncC_9.02_x64.7z'
  checksum64     = '1e4fee7ed4c566b709e90ef3f0c226d375976483bcf2f6172ebe4e64ac4455af'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
