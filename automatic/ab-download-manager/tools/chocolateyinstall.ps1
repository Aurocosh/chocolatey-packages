$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AB Download Manager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.5.1/ABDownloadManager_1.5.1_windows_x64.exe'
  checksum64     = 'e295deb51878a151eaf69b5b8c46c6cf444a1e0a5e03a5d3ea8f8f9247a7def6'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
