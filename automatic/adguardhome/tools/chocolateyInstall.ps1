$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.78/AdGuardHome_windows_386.zip'
  checksum       = '1be07b35765db199f88be3838473ba7682ef51dc58217dd49142c1650b5a4532'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.78/AdGuardHome_windows_amd64.zip'
  checksum64     = '481c8666b9ce8cd2ef12d4f758fcf07b40f7eb8a919a70e3355f15b5d84eddbe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
