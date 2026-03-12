$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/QSVEnc/releases/download/8.05/QSVEncC_8.05_Win32.7z'
  checksum       = '6f2ed0055919fb980d93105e0da159f4b2ac644f4f0fa9fc9d23b13e6eeec3c4'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/QSVEnc/releases/download/8.05/QSVEncC_8.05_x64.7z'
  checksum64     = '16040b7b6f4bfebd784a055692ee1ca8e72ad1bc96c6d92c3c469a05242ff9a3'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'QSVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "QSVEncC.exe"
}
