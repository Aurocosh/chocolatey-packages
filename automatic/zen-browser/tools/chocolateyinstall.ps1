$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Zen Browser*'
  url64bit       = 'https://github.com/zen-browser/desktop/releases/download/1.17.10b/zen.installer.exe'
  checksum64     = '3a2a4df465b8c1a7b52fbc518a59268f5f01b6402b4c5f0e7b54e3d4ffa281e4'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
