$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'autoscreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.16.2/AutoScreenshot_v1.16.2_Windows_setup.exe'
  checksum       = '8571910d71d57e598a87dcfa1053f642f61e662cf2763d801bb66622f941e547'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
