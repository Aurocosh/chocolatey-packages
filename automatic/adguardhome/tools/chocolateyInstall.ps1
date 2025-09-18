$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.66/AdGuardHome_windows_386.zip'
  checksum       = '1ebc9d3a2a3226976254a1ecab94f2050cb705fcf2418560c433cea9c1be9c18'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.66/AdGuardHome_windows_amd64.zip'
  checksum64     = '0b0653fa608adfbaa30624ae1c427c45a0d80992c3c4c105743eb2487b659ad9'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
