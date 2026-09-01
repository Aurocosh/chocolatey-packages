$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'YACReader*'
  url64bit       = 'https://github.com/YACReader/yacreader/releases/download/10.3.0/YACReader-v10.3.0.260901368-winx64-7z-qt6.exe'
  checksum64     = '927ebbddac7e49b7df351b8510ca848fb6cefde180d525b3ac1e873db7f5d1f5'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

