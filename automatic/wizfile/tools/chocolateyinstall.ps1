$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'WizFile*'
  url64bit       = 'https://antibody-software.com/files/wizfile_3_13_setup.exe'
  checksum64     = '58023159bdd8c1beaae54055afa95ff62f65f0e3c92eb33956b6fac88596b63e'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
