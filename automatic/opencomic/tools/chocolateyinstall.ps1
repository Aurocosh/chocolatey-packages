$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.4.0/OpenComic.Setup.1.4.0.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'e9d4fc6500112586afe9600229d036a145cc9f7b35eb64825fbb65e908bcd031'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
