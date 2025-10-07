$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Glasswire*'
  url            = 'https://download.glasswire.com/f/glasswire-setup-3.5.821-full.exe'
  checksum       = 'e1fbad7000249849828dac805541f2485bb43a3b4df17a788c96ed71f9291f94'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
