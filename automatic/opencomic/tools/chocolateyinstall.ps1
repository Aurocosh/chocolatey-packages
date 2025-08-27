$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.1/OpenComic.Setup.1.6.1.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'f6f339d1153974e72dfb988b9a26599a59af7840fe2f269f1b3f2c7f7201be8e'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
