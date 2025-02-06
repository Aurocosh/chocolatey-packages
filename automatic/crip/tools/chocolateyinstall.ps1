$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'crip*'
  url64bit       = 'https://github.com/Hakky54/certificate-ripper/releases/download/2.4.0/crip-windows-amd64.zip'
  checksum64     = '526c5fa48b4b02d7d3f43d8845f11897d18e27abfc21351b415a084e2ea83125'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
