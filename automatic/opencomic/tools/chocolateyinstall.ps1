$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://github.com/ollm/OpenComic/releases/download/v1.1.0/OpenComic.Setup.1.1.0.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  url64bit       = $url64
  softwareName   = 'opencomic*'
  checksum64     = 'ECAC622BF1D7795002EB940AE934B1065CA4FD922A92F00D088FC18C4C5FF3DE'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs