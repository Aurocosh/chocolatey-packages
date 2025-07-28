$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/ollm/OpenComic/releases/download/v1.6.0/OpenComic.Setup.1.6.0.exe'
  softwareName   = 'opencomic*'
  checksum64     = '8dbfd99ab3b9061328921a22fab49f965eede2d3473a068638d65e3e2beff37b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
