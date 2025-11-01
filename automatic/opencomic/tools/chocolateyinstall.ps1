$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.5/OpenComic.Setup.1.6.5.exe'
  softwareName   = 'opencomic*'
  checksum64     = '8e6aec54d42a17e130d1b439a8c9aac67ddd7ce8a0af5794c73e173a8503b172'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
