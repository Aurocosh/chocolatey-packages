$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'CherryTree*'
  url64bit       = 'https://github.com/giuspen/cherrytree/releases/download/v1.7.0/cherrytree_1.7.0.0_win64_setup.exe'
  checksum64     = 'ae919b8163e65899d626cb2e5b370bd0fdf11b603cc7a443fb021ea08ff6431d'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

