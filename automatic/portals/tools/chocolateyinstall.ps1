$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Portals*'
  url64bit       = 'https://downloads.portals-app.com/installers%2F3.4.0.0%2Fportals_installer_v3-4-0-0.exe?alt=media'
  checksum64     = '495964ccab0fdbbd370d61c0631cb3e8e0b8cbadb7c6edae6c53c049ed339866'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
