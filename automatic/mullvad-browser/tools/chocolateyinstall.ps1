$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Mullvad Browser*'
  url64bit       = 'https://github.com/mullvad/mullvad-browser/releases/download/15.0.21/mullvad-browser-windows-x86_64-15.0.21.exe'
  checksum64     = 'b2361d4b37ed8bf04bd7b9fed21e8e06fa35f651c7b3970f4165132ddfcc38b8'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
