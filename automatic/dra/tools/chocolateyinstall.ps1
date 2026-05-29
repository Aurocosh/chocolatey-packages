$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.10.2/dra-0.10.2-x86_64-pc-windows-msvc.zip'
  checksum64     = 'ab4178cfa9ee7a46983336438c2bd100b529d21c6cd6e378be52e814b59b40d2'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
