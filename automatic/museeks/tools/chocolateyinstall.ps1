$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Museeks*'
  url64bit       = 'https://github.com/martpie/museeks/releases/download/0.22.3/Museeks_0.22.3_x64-setup.exe'
  checksum64     = '8bab24a1297381e0f8e65098aa3221c57d9c3e3689d0538441395ea7221b0010'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

