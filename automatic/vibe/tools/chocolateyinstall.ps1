$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'vibe*'
  url64bit       = 'https://github.com/thewh1teagle/vibe/releases/download/v3.2.2/vibe_3.2.2_x64-setup.exe'
  checksum64     = 'e2437fa44ac32b3bc4ed636c1a1141f8b8cca38bb841e7c4535e5ef6e3971081'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

