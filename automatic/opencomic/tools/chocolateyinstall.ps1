$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.3/OpenComic.Setup.1.6.3.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'c0de746004c845324e0249abe8d6d4ab9d8c334d5dff744b2f3c46527f7056cb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
