$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.7.0/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = '5bf73fbc3057b9a64a1efe19d515e84a5e5e134f3163224f6c26618cb616a6b1'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
