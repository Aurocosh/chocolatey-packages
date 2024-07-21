$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'houdoku*'
  url            = 'https://github.com/fastfetch-cli/fastfetch/releases/download/2.18.1/fastfetch-windows-i686.zip'
  checksum       = '554beb38f2efb3591da213524c4b74d31d8178e6e194be8cbcc4d733a19e5a54'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/fastfetch-cli/fastfetch/releases/download/2.18.1/fastfetch-windows-amd64.zip'
  checksum64     = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
