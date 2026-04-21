$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Juggling Lab*'
  url            = 'https://storage.googleapis.com/jugglinglab-dl/JugglingLab-1.7.1.exe'
  checksum       = 'e1ec7dc8a186a6b43e8bc6fe904d5b5faf7788b7dc4d83e2f1639776a9f6e989'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

