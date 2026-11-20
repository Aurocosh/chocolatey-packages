$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v1.0.0/AdGuardHome_windows_386.zip'
  checksum       = 'a8cdec83f2d0c5bf9e1c1ea0875c862f39834b05ea2b7900c04a378deb5ac57f'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v1.0.0/AdGuardHome_windows_amd64.zip'
  checksum64     = '538f3863db11a054087e8b31eb7417a2c4b09a4cb689e29d59a49105dad45521'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
