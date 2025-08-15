$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.9.0/dra-0.9.0-x86_64-pc-windows-msvc.zip'
  checksum64     = 'a80305eb86b160e3b996663ec9b38d5a0cf5e642624882d52fcfd4b404375419'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
