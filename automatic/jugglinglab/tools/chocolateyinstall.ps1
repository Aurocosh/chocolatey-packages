$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Juggling Lab*'
  url            = 'https://storage.googleapis.com/jugglinglab-dl/JugglingLab-1.6.6.exe'
  checksum       = 'baab3f9a889ff8d87b9d14367b7eb525f7d66d6d4fafdc5d0d45d1e672a4e265'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

