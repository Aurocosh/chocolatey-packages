$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Juggling Lab*'
  url            = 'https://storage.googleapis.com/jugglinglab-dl/JugglingLab-1.6.5.exe'
  checksum       = 'a9ef1c00fe88915fc5ff598381559caf7d35af5d85396e29da99dc0355944422'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

