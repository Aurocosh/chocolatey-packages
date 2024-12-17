$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.4.2/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = 'f702aadc6391a2a809080767089fb54ccb35264934d1ffdac554316dbabce1dd'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
