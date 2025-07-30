$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Hayase*'
  url64bit       = 'https://github.com/hayase-app/ui/releases/download/v6.4.18/win-hayase-6.4.18-installer.exe'
  checksum64     = '5856a668be990d3ac8a73cca343f93ecaceb9ec1550608566f37e33b26f27cff'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
