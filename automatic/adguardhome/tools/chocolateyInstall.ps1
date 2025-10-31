$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.69/AdGuardHome_windows_386.zip'
  checksum       = '85a4a15c141a4efb6832ab270f33c81c90ee3cd162261d6ed78a09aa2e8d6eb9'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.69/AdGuardHome_windows_amd64.zip'
  checksum64     = '6ec6f167a5769c6e454eebf1bafb0c29ebb8e62d71976ba53e26eaed930d8de0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
