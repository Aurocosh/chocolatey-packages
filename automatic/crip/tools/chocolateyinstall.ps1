$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'crip*'
  url64bit       = 'https://github.com/Hakky54/certificate-ripper/releases/download/2.3.0/crip-windows-amd64.zip'
  checksum64     = '7f24ec0ac70d0008378b8a9fcea896fdbfcab33abb451995313e5541827bee37'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
