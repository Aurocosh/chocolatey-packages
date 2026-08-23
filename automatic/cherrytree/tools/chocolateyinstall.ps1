$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'CherryTree*'
  url64bit       = 'https://github.com/giuspen/cherrytree/releases/download/v1.7.2/cherrytree_1.7.2.0_win64_setup.exe'
  checksum64     = '9cbba0681adfa726bdd3da79ceefa52d29482d6f6a6223ad9ec9ad57d87e91e4'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

