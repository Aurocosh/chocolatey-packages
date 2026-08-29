$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dopamine*'
  url64bit       = 'https://github.com/digimezzo/dopamine/releases/download/v3.0.10/Dopamine-3.0.10.exe'
  checksum64     = '560956e1a04597feddcb90908a341227d536177866b35a432f15ec30becca009'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

