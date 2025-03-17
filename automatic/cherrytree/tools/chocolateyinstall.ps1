$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'cherrytree*'
  url64bit       = 'https://www.giuspen.com/software/cherrytree_0.99.41.0_win64_setup.exe'
  checksum64     = '7c60e7c6aac949c9862833d92a84e9b76faa4c95f3d689f2448e16296e48e448'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

