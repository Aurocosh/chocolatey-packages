$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.4.1/OpenComic.Setup.1.4.1.exe'
  softwareName   = 'opencomic*'
  checksum64     = '0535e37b5b38802578adbc90e8efc602b411da960e4338cbf7526ed64746bed9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
