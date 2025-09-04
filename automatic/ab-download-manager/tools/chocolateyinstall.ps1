$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'AB Download Manager*'
  url64bit       = 'https://github.com/amir1376/ab-download-manager/releases/download/v1.6.11/ABDownloadManager_1.6.11_windows_x64.exe'
  checksum64     = 'b17654492e135070178c74e501abc83c57021af4857c6789c16f67dcf63f4994'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
