$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Museeks*'
  url64bit       = 'https://github.com/martpie/museeks/releases/download/0.20.9/Museeks_0.20.9_x64-setup.exe'
  checksum64     = '6dd9270c2d4e5c8a2712b0cbaf594c2956840bd2b0f050b10a247380351b75ac'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

