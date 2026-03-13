$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'vibe*'
  url64bit       = 'https://github.com/thewh1teagle/vibe/releases/download/v3.0.19/vibe_3.0.19_x64-setup.exe'
  checksum64     = '94045ea713c9d70cf1a5727cf4c1cc73117de128526fa89d374f3ff530c7f5a3'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

