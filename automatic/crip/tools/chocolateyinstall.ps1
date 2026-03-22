$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'crip*'
  url64bit       = 'https://github.com/Hakky54/certificate-ripper/releases/download/2.7.1/crip-windows-amd64.zip'
  checksum64     = 'c98b25872771312ac88cf6a475a7570bf5f8c872d6bf406cba88196e2a7d430f'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
