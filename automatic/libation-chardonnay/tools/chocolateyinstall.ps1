$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Chardonnay)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v13.5.1/Libation.13.5.1-windows-chardonnay-x64-setup.exe'
  checksum64     = '7982d664de1b6db1a0c3874b08b25c5e1a890a96c5776f00315b548edec39cc9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

