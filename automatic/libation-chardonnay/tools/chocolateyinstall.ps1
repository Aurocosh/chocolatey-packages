$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation Chardonnay*'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v13.5.0/Libation.13.5.0-windows-chardonnay-x64-setup.exe'
  checksum64     = 'd8db3cb7de4d938e9fe5786c49a7488d53f00087ab6677f57a0c55a11565f99f'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

