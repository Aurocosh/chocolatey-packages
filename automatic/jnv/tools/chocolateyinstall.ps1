$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.6.2/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = '5cb9616599e3fffad6385ac6b6e47bf5cfcfedc0773b6588b6199d667c20084a'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
