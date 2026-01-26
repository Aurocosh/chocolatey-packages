$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'crip*'
  url64bit       = 'https://github.com/Hakky54/certificate-ripper/releases/download/2.7.0/crip-windows-amd64.zip'
  checksum64     = '5a304d2df02bf5c6a904e2260d827d4d103bc8bb32e668dd49e25d847b2959b0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
