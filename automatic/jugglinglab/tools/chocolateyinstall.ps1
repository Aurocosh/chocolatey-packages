$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Juggling Lab*'
  url            = 'https://storage.googleapis.com/jugglinglab-dl/JugglingLab-1.7.6.exe'
  checksum       = '43cd6ca7d1b0c0a0a23c7648d8fa0c7e771df1c0139d77aa113c60e01481d91f'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

