$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'librespeed-cli*'
  url            = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.15/librespeed-cli_1.0.15_windows_386.zip'
  checksum       = '6dc2f7b65f249186a924693498f7e84bb3557b6e44b029ea958aa24916444013'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.15/librespeed-cli_1.0.15_windows_amd64.zip'
  checksum64     = '198dfb0b5a01a2e7a0bf440de674889967434a72f61d79afb783b44da35cc157'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
