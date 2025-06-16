$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'rustscan*'
  url            = 'https://github.com/bee-san/RustScan/releases/download/2.4.1/x86-windows-rustscan.exe.zip'
  checksum       = '5d5386d27c4c43ab144ce47f0dfcbb37d40d0c5f40127db1e6032a098380d3d6'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/bee-san/RustScan/releases/download/2.4.1/x86_64-windows-rustscan.exe.zip'
  checksum64     = 'e26c16f3adccb3c9dd737068941d1de850939b80193c5156218079582f5a7685'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
