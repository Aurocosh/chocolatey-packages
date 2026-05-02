$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'lychee*'
  url64bit       = 'https://github.com/lycheeverse/lychee/releases/download/lychee-v0.24.2/lychee-x86_64-pc-windows-msvc.zip'
  checksum64     = '32975d1493ee1a975d6bb41e4fb56fe419cb442ded628bb772ba2e614acfacad'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
