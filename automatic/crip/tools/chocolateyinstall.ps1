$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'crip*'
  url64bit       = 'https://github.com/Hakky54/certificate-ripper/releases/download/2.4.1/crip-windows-amd64.zip'
  checksum64     = 'f3ae2d2762e89f75c85061d1cd4b0f62341a130637d4f132518f1d757e031fbe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
