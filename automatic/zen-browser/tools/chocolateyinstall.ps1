$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Zen Browser*'
  url64bit       = 'https://github.com/zen-browser/desktop/releases/download/1.22.1b/zen.installer.exe'
  checksum64     = '5e648caa0b1fb6e6bbb0b5a6162209788c45804d4c51ad8db9c434fd88622e24'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
