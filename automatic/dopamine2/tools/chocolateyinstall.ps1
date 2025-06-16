$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'Dopamine*'
  url            = 'https://github.com/digimezzo/dopamine-windows/releases/download/v2.0.10.4000/Dopamine.2.0.10.Release.msi'
  checksum       = '3fbbeb051dbf6fabf67211075b3410b612f024255d0e1a840b021b39e1c82892'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

