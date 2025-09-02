$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'crip*'
  url64bit       = 'https://github.com/Hakky54/certificate-ripper/releases/download/2.5.0/crip-windows-amd64.zip'
  checksum64     = 'db99c81779122d2abb1f848228528b54b1e2122035543193baefe5c0ae23f2d6'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
