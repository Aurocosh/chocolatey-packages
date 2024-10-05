$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.3.0/OpenComic.Setup.1.3.0.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'b5ff2cb1a092808f686134af1e97a5d6eda8c727fcc74a1aec64c144d423e089'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
