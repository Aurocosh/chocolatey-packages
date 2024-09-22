$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'ABDownloadManager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.0.10/ABDownloadManager_1.0.10_windows.msi'
  checksum64     = 'fa0cd8df4130649c716f359874fd687ecce7c9b289fbfe8a6ef6ad88c48e9f8c'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet'  # Windows Installer
}

Install-ChocolateyPackage @packageArgs
