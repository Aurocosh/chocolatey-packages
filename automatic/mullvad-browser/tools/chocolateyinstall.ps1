$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Mullvad Browser*'
  url64bit       = 'https://github.com/mullvad/mullvad-browser/releases/download/16.0.2/mullvad-browser-windows-x86_64-16.0.2.exe'
  checksum64     = 'd2f8c8e98e619c1ac8cbae56ce4f5d0f599fd65f674ca4c9408bdf9be8ac35af'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
