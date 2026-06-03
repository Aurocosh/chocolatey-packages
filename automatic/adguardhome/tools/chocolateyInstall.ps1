$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.77/AdGuardHome_windows_386.zip'
  checksum       = 'c085d5429d3064226a34a20badb931e934645bdfa1c29c20bd7c0822b24f15f1'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.77/AdGuardHome_windows_amd64.zip'
  checksum64     = 'd0fe5a41e13558e7dce22b7810d354745d870b31eeb2d4eb63207f918c0e66b8'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
