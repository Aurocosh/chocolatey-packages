$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.6.2/dra-0.6.2-x86_64-pc-windows-msvc.zip'
  checksum64     = '4aa883afb144658d43df9c42a8f902af1503151992d399b20eafa449a36b5a9d'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
