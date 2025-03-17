$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'CherryTree*'
  url64bit       = 'https://github.com/giuspen/cherrytree/releases/download/v1.3.0/cherrytree_1.3.0.1_win64_setup.exe'
  checksum64     = '8751482af6e538d596195afe6c191e621836f2686b631e25ef54023043134176'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

