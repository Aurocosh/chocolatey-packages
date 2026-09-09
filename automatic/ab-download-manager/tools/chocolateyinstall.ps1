$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AB Download Manager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.10.4/ABDownloadManager_1.10.4_windows_x64.exe'
  checksum64     = '7f0b2a0f939bc1248e68c207393ca181ff5f4d74f4c369d2d68f6b9b0f11fcf0'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
