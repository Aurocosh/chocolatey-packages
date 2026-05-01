$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/9.16/NVEncC_9.16_Win32.7z'
  checksum       = 'ca4b9d352c794203c6cb037eec9cd4cd4471d73f75b59e2495e84eb25d634cf5'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/9.16/NVEncC_9.16_x64.7z'
  checksum64     = '31f53565c59c62659213826447c6ecca1134b6bbc3915fa452bd53557a040c4c'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
