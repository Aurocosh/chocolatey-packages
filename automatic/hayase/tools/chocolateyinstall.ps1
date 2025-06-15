$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Hayase*'
  url64bit       = 'https://github.com/ThaUnknown/miru/releases/download/v6.3.7/win-hayase-6.3.7-installer.exe'
  checksum64     = 'ee219fa7f9e1f359435c424811185e9fd750f38993a85cb82230da72c9de5fdc'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
