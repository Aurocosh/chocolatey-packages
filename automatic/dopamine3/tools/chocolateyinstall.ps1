$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Dopamine*'
  url64bit       = 'https://github.com/digimezzo/dopamine/releases/download/v3.0.8/Dopamine-3.0.8.exe'
  checksum64     = '41c999ae094d4e0546b0d93bd27e5e69065fc1f64305488cc52b482a41ec8542'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

