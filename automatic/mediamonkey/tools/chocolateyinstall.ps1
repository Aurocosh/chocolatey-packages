$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'MediaMonkey*'
  url            = 'https://www.mediamonkey.com/sw/MediaMonkey_2024.2.0.3184.exe'
  checksum       = 'd0c30bc4ccb54cff094ba6323a2c0fdebf307567bcad43e3b503a8a93df1a764'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs
