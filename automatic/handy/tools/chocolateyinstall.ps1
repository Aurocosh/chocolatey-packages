$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Handy*'
  url64bit       = 'https://github.com/cjpais/Handy/releases/download/v0.8.0/Handy_0.8.0_x64-setup.exe'
  checksum64     = 'a738804b982870caa86b6dfb4b9bf5f0d7de97ced468fa87eda299f1a9377eec'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

