$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'vibe*'
  url64bit       = 'https://github.com/thewh1teagle/vibe/releases/download/v3.1.5/vibe_3.1.5_x64-setup.exe'
  checksum64     = '7c716bfc74fc83e5d4087df932afb415b7f0442a6fe848c2d335f5370573ddbb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

