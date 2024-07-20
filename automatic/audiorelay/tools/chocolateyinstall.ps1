$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  url64bit       = 'https://dl.audiorelay.net/setups/windows/audiorelay-0.27.5.exe'
  checksum64     = 'ef4b2398d492a12ee25d25917b725294523b97bb6e532bed1a3e5ff020d6368f'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT'
}

Install-ChocolateyPackage @packageArgs
