$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'librespeed-cli*'
  url            = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.13/librespeed-cli_1.0.13_windows_386.zip'
  checksum       = '4a61d001996640935363c2c6fd87e4c150555c37850bf7380ae96758fe5445eb'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.13/librespeed-cli_1.0.13_windows_amd64.zip'
  checksum64     = '0d10a38858a05998fe1af070ca3c98e6dc038c0883b22c18918b33c855789f2a'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
