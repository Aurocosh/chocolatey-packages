$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AB Download Manager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.9.2/ABDownloadManager_1.9.2_windows_x64.exe'
  checksum64     = 'd4006e160854c5ca0b78a1d27c95f5d27c77547de819d543fecef9d5abd64c18'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
