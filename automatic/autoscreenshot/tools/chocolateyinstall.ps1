$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'autoscreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.2/AutoScreenshot_v1.23.2_Windows_setup.exe'
  checksum       = '5fd1fa33f5cb18653b12cfbedfd99cd6d031b136440a8419e1b738e1a709b55e'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
