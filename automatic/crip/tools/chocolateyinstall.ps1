$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'crip*'
  url64bit       = 'https://github.com/Hakky54/certificate-ripper/releases/download/2.6.0/crip-windows-amd64.zip'
  checksum64     = '479c33a877049d66f19febd606793e8c8635d3079ca3f4a9562f56b7efc1f742'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
