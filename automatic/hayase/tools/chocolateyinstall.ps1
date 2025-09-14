$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Hayase*'
  url64bit       = 'https://github.com/hayase-app/ui/releases/download/v6.4.31/win-hayase-6.4.31-installer.exe'
  checksum64     = 'f00b675d8e3fbb93c2e9c54346af34ec315791f3a1c8aaf518041dab44e5c592'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
