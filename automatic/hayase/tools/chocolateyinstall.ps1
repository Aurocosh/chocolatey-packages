$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Hayase*'
  url64bit       = 'https://github.com/hayase-app/ui/releases/download/v6.4.13/win-hayase-6.4.13-installer.exe'
  checksum64     = '15040ee1ebe48e6ff07404011ba81dd1ccd8d0e7cfb893feb53552123ee050db'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
