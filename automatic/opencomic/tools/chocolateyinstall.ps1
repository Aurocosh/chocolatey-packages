$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.5.0/OpenComic.Setup.1.5.0.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'ace786e9e6065edd35fc79fad5f9c2d46afe125826666bfc0914c36d5cab1179'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
