$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'autoscreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.3.1/AutoScreenshot_v1.23.3.1_Windows_setup.exe'
  checksum       = '781a08438322e3529d5a45ee6c2ea5cb744bbc22c063e2731e36f2f463695997'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
