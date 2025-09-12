$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Hayase*'
  url64bit       = 'https://github.com/hayase-app/ui/releases/download/v6.4.29/win-hayase-6.4.29-installer.exe'
  checksum64     = 'd5ad5a3e16458531c71e7ece3227a2d5590f728555941779ad44aaffc1c3b0e6'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
