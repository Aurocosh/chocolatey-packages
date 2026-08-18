$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Mullvad Browser*'
  url64bit       = 'https://github.com/mullvad/mullvad-browser/releases/download/15.0.20/mullvad-browser-windows-x86_64-15.0.20.exe'
  checksum64     = '7eb168be0eb88a5517e8a80e162d6d90205c65472604e7c634036e473b83d193'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
