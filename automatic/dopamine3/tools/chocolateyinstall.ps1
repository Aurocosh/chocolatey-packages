$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dopamine*'
  url64bit       = 'https://github.com/digimezzo/dopamine/releases/download/v3.0.12/Dopamine-3.0.12.exe'
  checksum64     = '87b8db0aefc0c57390896eec0ce3966908ba7d0dad58d3d117f0f921f2ba8eb8'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

