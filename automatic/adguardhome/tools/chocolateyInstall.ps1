$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.74/AdGuardHome_windows_386.zip'
  checksum       = '67de754341b22df4e59921e00835a3defe1f779ca6538885681b2cd7fb8df569'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.74/AdGuardHome_windows_amd64.zip'
  checksum64     = 'c7c892e8734d3968d61506f4a3add612513c4779f157b7eb7453fb924ca2e7c8'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
