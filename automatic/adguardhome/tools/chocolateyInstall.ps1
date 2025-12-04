$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.70/AdGuardHome_windows_386.zip'
  checksum       = '878ed86ae31e949575e274caaa59d4ebf565b96669a191a0ef7f0cccd6ca81b1'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.70/AdGuardHome_windows_amd64.zip'
  checksum64     = '2471d76c74be5a84011d07f7318f9ca8ac95aaceee0f15dce7eff1d542ee458d'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
