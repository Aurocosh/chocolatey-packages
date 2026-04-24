$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'lychee*'
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.24.0/lychee-lychee-v0.24.0-x86_64-pc-windows-msvc.zip'
  checksum64     = '96879dad6c3bbb843f9dba8f2efea817cf1ef04dfc7cb89e411750238d72bfe3'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
