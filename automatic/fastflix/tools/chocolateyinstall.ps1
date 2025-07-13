$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'FastFlix*'
  url64bit       = 'https://github.com/cdgriffith/FastFlix/releases/download/5.12.4/FastFlix_5.12.4_installer.exe'
  checksum64     = 'eb86e1d20fb5dfc9f87ba3d9581c29b3dcc0b6c41fb011221655fc7ff322730d'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
