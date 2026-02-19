$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Museeks*'
  url64bit       = 'https://github.com/martpie/museeks/releases/download/0.23.4/Museeks_0.23.4_x64-setup.exe'
  checksum64     = '66d45b21f309cca2646689d06656dec1c9115a0b31da7c3a078aa6bdcabc327c'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

