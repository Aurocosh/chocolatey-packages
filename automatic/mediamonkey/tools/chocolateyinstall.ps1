$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'MediaMonkey*'
  url            = 'https://www.mediamonkey.com/sw/MediaMonkey_2024.2.2.3222.exe'
  checksum       = 'c2d569dc4f357ee34d26e92deb310254ef44fa67a4771b2bf7b244e595e2c85c'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs
