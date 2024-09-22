$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.2.0/OpenComic.Setup.1.2.0.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'e4ebfee707c03b107a54141a6aca35425126726660094c00db88e8bfd561641d'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
