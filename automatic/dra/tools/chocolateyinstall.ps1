$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.10.1/dra-0.10.1-x86_64-pc-windows-msvc.zip'
  checksum64     = '41ca4f08086fe8c254f127c13796b18b8f21d3aea0ddbb76fc32572f5fbec562'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
