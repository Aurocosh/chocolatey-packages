$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  url            = 'https://github.com/rigaya/VCEEnc/releases/download/9.20/VCEEncC_9.20_Win32.7z'
  checksum       = '183a1cf817d6e7f6d2f460f692bf36010cd13fe76522913c870e2c5ad79d12c4'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/9.20/VCEEncC_9.20_x64.7z'
  checksum64     = '706d4a6b5fe62224cd10dbc9b26831d60539839e12924b2927c4d7ae7c2c686d'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
