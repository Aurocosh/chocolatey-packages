$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'autoscreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.1/AutoScreenshot_v1.23.1_Windows_setup.exe'
  checksum       = 'f9be3cad9b28eee5a3c34ee8b1e1f1fbf2d94ef0dae9e1c1d7c0f9809e7fcd3a'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
