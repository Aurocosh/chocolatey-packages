$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Mullvad Browser*'
  url64bit       = 'https://github.com/mullvad/mullvad-browser/releases/download/15.0.26/mullvad-browser-windows-x86_64-15.0.26.exe'
  checksum64     = 'acb32d9e834006d1e25da7ab55f94ff29b1dc738e0130829dda1d88b7f46f9f0'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
