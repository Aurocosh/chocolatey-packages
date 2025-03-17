#$ErrorActionPreference = 'Stop';
$packageName= 'mediamonkey'
#$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.mediamonkey.com/MediaMonkey_Setup.exe'
$packageArgs = @{
  packageName   = $packageName
  # unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  # validExitCodes= @(0)
  softwareName  = 'mediamonkey*'
  checksum      = '3580c5bee97860fabd5ccdcbdb532de2c2ab31689d5643291d46b1adc3f1a26c'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
