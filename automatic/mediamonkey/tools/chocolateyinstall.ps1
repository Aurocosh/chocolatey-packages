$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'MediaMonkey*'
  url            = 'https://www.mediamonkey.com/sw/MediaMonkey_2024.2.2.3223.exe'
  checksum       = 'cc8afe2a7f37b3072ca6a76e8817100054c3e9730857188d6dea27f72c744d51'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs
