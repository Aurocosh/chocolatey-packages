$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AdGuardHome*'
  url            = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.75/AdGuardHome_windows_386.zip'
  checksum       = '79abba3eb903675b86bd2d8ac2eb01c65bdc116caca27f7217edf6b4dcf9c690'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.75/AdGuardHome_windows_amd64.zip'
  checksum64     = 'ae01eb4b70786cd273f3925b83e0b9c25b296d5ef5ca173e0337e0a8d7d94432'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
