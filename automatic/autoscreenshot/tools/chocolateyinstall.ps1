$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'autoscreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.22.1/AutoScreenshot_v1.22.1_Windows_setup.exe'
  checksum       = '68097a625db9afa55182071e477d6d9d463b5dfc374f61730a15d6239ee6f162'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
