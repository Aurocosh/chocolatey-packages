$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.73/AdGuardHome_windows_386.zip'
  checksum       = '69c5638bb26871af9fdcc6967bf94800b37d76e1424c69961cbe90acac0f5ac9'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.73/AdGuardHome_windows_amd64.zip'
  checksum64     = 'ccf42cb10887447b84497da99e756acee755794e01ede60bf6c33ef266bc0b69'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
