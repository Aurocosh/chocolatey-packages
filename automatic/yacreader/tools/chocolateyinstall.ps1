$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'YACReader*'
  url64bit       = 'https://github.com/YACReader/yacreader/releases/download/10.4.0/YACReader-v10.4.0.261009428-winx64-7z-qt6.exe'
  checksum64     = '676ceb05712591e33c2d2eb833203d15e016de01acd1426ecb8758f0ef63b778'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

