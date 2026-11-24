$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Mullvad Browser*'
  url64bit       = 'https://github.com/mullvad/mullvad-browser/releases/download/16.0.3/mullvad-browser-windows-x86_64-16.0.3.exe'
  checksum64     = '22d99048713e00ca8d5094feade7363f7c7653b131424df7149f419dc87ca530'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
