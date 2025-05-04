$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Zen Browser*'
  url64bit       = 'https://github.com/zen-browser/desktop/releases/download/1.12.1b/zen.installer.exe'
  checksum64     = 'a40eb4d08810f17358e130a5f172884e38f972e858a6eb02fb2361cc49cb3d68'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
