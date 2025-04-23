$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/8.04/NVEncC_8.04_Win32.7z'
  checksum       = 'f249c799ad5d38b48d9da9fc3289abd06fdd798094fe09b58283400114d26f42'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/8.04/NVEncC_8.04_x64.7z'
  checksum64     = '0a814a07f9753c006d1dc1419783885e85cb89efeb3548e26f9eb206758bdfd7'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
