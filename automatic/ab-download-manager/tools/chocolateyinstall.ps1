$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AB Download Manager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.6.13/ABDownloadManager_1.6.13_windows_x64.exe'
  checksum64     = '7fd5a6b8b53d5c88397bd79886ef1ffd6fea882d7fb590d3fea428036f973672'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
