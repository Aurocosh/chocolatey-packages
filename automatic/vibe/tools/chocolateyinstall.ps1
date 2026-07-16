$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'vibe*'
  url64bit       = 'https://github.com/thewh1teagle/vibe/releases/download/v3.0.23/vibe_3.0.23_x64-setup.exe'
  checksum64     = 'a754b5416ea5a311511c836507aad0e918d59205b09a59516293f2e531433fe8'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

