$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Juggling Lab*'
  url            = 'https://storage.googleapis.com/jugglinglab-dl/JugglingLab-1.6.9.exe'
  checksum       = '291302316b8ef09b5d2275b9fc1b3161258816642e262ae74e402893ff75d2cc'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

