$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'MediaMonkey*'
  url            = 'https://www.mediamonkey.com/sw/MediaMonkey_2024.0.0.3082.exe'
  checksum       = 'daf78401fbbffa0ad5e77e80a9ac4a09686f5e1624e098ccceb9ee6abe9cae04'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs
