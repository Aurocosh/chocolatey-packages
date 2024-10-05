$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.3.1/OpenComic.Setup.1.3.1.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'b2ffafbbe79c674b2dc7775b75729631f0963aaaeffb3599647facf79f5adaf3'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
