$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'YACReader*'
  url64bit       = 'https://github.com/YACReader/yacreader/releases/download/10.2.0/YACReader-v10.2.0.260808325-winx64-7z-qt6.exe'
  checksum64     = 'd8a248280a72245e9a6cdb53b1d2847ebf0cdc8e59b445ccf6eb63ac157a08cb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

