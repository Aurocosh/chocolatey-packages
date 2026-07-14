$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'vibe*'
  url64bit       = 'https://github.com/thewh1teagle/vibe/releases/download/v3.0.22/vibe_3.0.22_x64-setup.exe'
  checksum64     = '01680eed1c6715214c4332d24303e796a754d5bd31f29a2a4fa5cc44539f7024'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

