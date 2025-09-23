$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Museeks*'
  url64bit       = 'https://github.com/martpie/museeks/releases/download/0.23.1/Museeks_0.23.1_x64-setup.exe'
  checksum64     = '0128a6838d7dde0a7d0cd26916c1232ee6b7c4fd241c520dc884e9f7ec21795e'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

