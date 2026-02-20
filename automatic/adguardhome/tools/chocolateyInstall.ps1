$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.72/AdGuardHome_windows_386.zip'
  checksum       = 'b8fff79a20845ce60e100824da81b99d0f3a86d484ac7d8d02f1c97ab59a8496'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.72/AdGuardHome_windows_amd64.zip'
  checksum64     = '128709c6a01dae61e09eed528d7702c4d14a2b23fb48087b1ff578dfadcc5893'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
