$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v2.0.0/OpenComic.Setup.2.0.0.exe'
  softwareName   = 'opencomic*'
  checksum64     = '1ffe1f0a321e383a9491afc5ab9969f6aa89ac3fbecf946e2b26d9dfe8bf225b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
