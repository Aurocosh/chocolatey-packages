$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.80/AdGuardHome_windows_386.zip'
  checksum       = 'f7967d4064285376f2d53e8bf02f12536fe90a16646de5c2b45424245cc1479b'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.80/AdGuardHome_windows_amd64.zip'
  checksum64     = '46f69352b088595ff2764917d1209a69a3e8fa7a60a643201fd0d4da3d9c94bb'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
