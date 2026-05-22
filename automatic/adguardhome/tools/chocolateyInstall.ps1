$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.76/AdGuardHome_windows_386.zip'
  checksum       = 'c3ad01d1eef8e1e28168c6e0059e8c94253bb4ce8fbd4601c11918b8b8f3f93c'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.76/AdGuardHome_windows_amd64.zip'
  checksum64     = '80748442082f07dfdf9c1cdaeeb88e522e99afcdf1aedca3848338ce42c23ee6'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
