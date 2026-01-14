$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'CherryTree*'
  url64bit       = 'https://github.com/giuspen/cherrytree/releases/download/v1.6.3/cherrytree_1.6.3.0_win64_setup.exe'
  checksum64     = '021583bdd0cee0a6258829ab8ec460373314731bfd5f1a3b154b8f072be5c45b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

