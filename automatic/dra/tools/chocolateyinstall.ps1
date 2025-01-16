$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.7.1/dra-0.7.1-x86_64-pc-windows-msvc.zip'
  checksum64     = '749cad10a38a8035914d718ea95aa272da522c926e40079dd7a1cababc129315'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
