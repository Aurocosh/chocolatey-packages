$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.8.0/dra-0.8.0-x86_64-pc-windows-msvc.zip'
  checksum64     = '211cfc6e8faf2d6ebc59297416b930643e9640ba6d1ecb3da55ea2b561d5dc05'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
