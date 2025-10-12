$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Hayase*'
  url64bit       = 'https://github.com/hayase-app/ui/releases/download/v6.4.34/win-hayase-6.4.34-installer.exe'
  checksum64     = '8b62fbabcac31198de73a42e6dcbf5990311eafa2bc3edda480beee849d9add9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
