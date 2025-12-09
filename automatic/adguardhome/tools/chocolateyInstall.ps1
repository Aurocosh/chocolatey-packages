$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.71/AdGuardHome_windows_386.zip'
  checksum       = '821382b8cb629ecd0d7d07808cb759a3dc1fe3becca3960412a4384c6ea64f3b'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.71/AdGuardHome_windows_amd64.zip'
  checksum64     = '366af0f93e496ef96f13cb3ac1e0004fbd195a9d02ffc6bb4ff69aa20067190d'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
