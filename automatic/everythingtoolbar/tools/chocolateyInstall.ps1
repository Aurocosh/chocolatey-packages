$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'EverythingToolbar*'
  url64bit       = 'https://github.com/srwi/EverythingToolbar/releases/download/2.3.0/EverythingToolbar-2.3.0-x64.exe'
  checksum64     = 'e732c93b299a073f7ee0fbc6707336b8037da5d7af190957e080d68c0bb5d158'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

