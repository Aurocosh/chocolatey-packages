$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Handy*'
  url64bit       = 'https://github.com/cjpais/Handy/releases/download/v0.9.5/Handy_0.9.5_x64-setup.exe'
  checksum64     = 'b2436cfadf233bb749d0d56fd64008aa9ee9d94b93af5ee992b0cbc6b7f71a13'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

