$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'YACReader*'
  url64bit       = 'https://github.com/YACReader/yacreader/releases/download/10.3.1/YACReader-v10.3.1.260922387-winx64-7z-qt6.exe'
  checksum64     = 'd3ad539a89a917501b7aade66432534c1c3918a9d74a8bdd11dea2c6aeafb12c'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

