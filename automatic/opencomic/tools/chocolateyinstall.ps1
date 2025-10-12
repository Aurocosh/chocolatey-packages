$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.4/OpenComic.Setup.1.6.4.exe'
  softwareName   = 'opencomic*'
  checksum64     = 'de50b83456236eb1eb2ef43661a0a792aaf97c355a7b9c46a0d9f58821c95c0f'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
