$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'librespeed-cli*'
  url            = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.14/librespeed-cli_1.0.14_windows_386.zip'
  checksum       = '03adc99468ab21fb2444103355d1cf28524209597306641081713c34b3a08a17'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.14/librespeed-cli_1.0.14_windows_amd64.zip'
  checksum64     = '324f9bc16f3b9bb6bfa6af89bad1e3e5183ae8c91464b3cb3fc2db8df1d6b503'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
