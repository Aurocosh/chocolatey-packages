$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Zen Browser*'
  url64bit       = 'https://github.com/zen-browser/desktop/releases/download/1.8.1b/zen.installer.exe'
  checksum64     = 'a4ef5e288fc7abd6a430bb75a10f48beb62a5522b35b4c35b5cd30e4a28c25d5'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
