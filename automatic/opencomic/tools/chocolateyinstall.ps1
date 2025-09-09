$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.2/OpenComic.Setup.1.6.2.exe'
  softwareName   = 'opencomic*'
  checksum64     = '990b599ebfea28054d5b7b9c4b3032f317457bf7ff88a6650dd0ceeffb420876'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
