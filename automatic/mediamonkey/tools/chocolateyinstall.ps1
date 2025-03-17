$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'MediaMonkey*'
  url            = 'https://github.com/SpikeHD/Dorion/releases/download/v6.5.0/Dorion_6.5.0_x64-setup.exe'
  checksum       = '3580c5bee97860fabd5ccdcbdb532de2c2ab31689d5643291d46b1adc3f1a26c'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs
