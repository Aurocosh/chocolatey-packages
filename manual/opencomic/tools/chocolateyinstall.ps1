$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://github.com/ollm/OpenComic/releases/download/v1.0.0/OpenComic.Setup.1.0.0.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  url64bit       = $url64
  softwareName   = 'opencomic*'
  checksum64     = '52F89DD22C3FA684885F0AF32245D81AB5895F06A2CC7837232C75BA52906DDA'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs