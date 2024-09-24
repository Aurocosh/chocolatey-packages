$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.1.0/ABDownloadManager_1.1.0_windows.msi'
  checksum64     = '3470aea121ae5798d9f8d76ea91a7659cf1571468a8328e41c7d38124fb8d1fc'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet'  # Windows Installer
}

Install-ChocolateyPackage @packageArgs
