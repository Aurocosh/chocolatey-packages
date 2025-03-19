$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.8.1/dra-0.8.1-x86_64-pc-windows-msvc.zip'
  checksum64     = '22848be1e324344dc2bc09ab5992101d9f9fe1b3656c228395947259f23fa7f8'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
