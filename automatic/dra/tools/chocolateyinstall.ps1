$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'DRA*'
  url64bit       = 'https://github.com/devmatteini/dra/releases/download/0.6.3/dra-0.6.3-x86_64-pc-windows-msvc.zip'
  checksum64     = '07e5723fb7b3bdce71cd6e32128afab6b433e2178ae8bf840a8f6385a047fecd'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
