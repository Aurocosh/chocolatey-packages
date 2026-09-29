$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'YACReader*'
  url64bit       = 'https://github.com/YACReader/yacreader/releases/download/10.3.2/YACReader-v10.3.2.260928407-winx64-7z-qt6.exe'
  checksum64     = '2f1456db5a1a6c5585d45643135aa8c280ffbc60b68b09e2bfedefbe593e5a44'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

