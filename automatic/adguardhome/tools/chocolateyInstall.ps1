$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.79/AdGuardHome_windows_386.zip'
  checksum       = '19ffa4c7583e13e7818b472079a79bf1c81ccb40be3a91fe96e4da056bfe9238'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.79/AdGuardHome_windows_amd64.zip'
  checksum64     = 'e42294dc26b2c0d8f4576a91f09aa5129ffdfb7b647026fac77f0abac9acffce'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
