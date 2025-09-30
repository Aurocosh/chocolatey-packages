$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.67/AdGuardHome_windows_386.zip'
  checksum       = '6ef49bb1801653dbae411f3cf932fc0ea306e19610bb3960e73c81fa2cb1a823'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.67/AdGuardHome_windows_amd64.zip'
  checksum64     = '4164e0f805e23ee2c0ae87f6069913ed0ee40f68dd4888bd9618b660af0bdd33'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
