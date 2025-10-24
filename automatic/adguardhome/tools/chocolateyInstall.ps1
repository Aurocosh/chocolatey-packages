$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.68/AdGuardHome_windows_386.zip'
  checksum       = '848fbda7f6926e9ae472a41193d2ce33c15ebfa4a895bff2d94aa103ab7d2658'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.68/AdGuardHome_windows_amd64.zip'
  checksum64     = 'c2a6b5f8cda43e30c041b341ceef6651c31569169335147279c22a0b6e0858fa'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
