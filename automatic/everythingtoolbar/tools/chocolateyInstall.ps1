$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'EverythingToolbar*'
  url64bit       = 'https://github.com/srwi/EverythingToolbar/releases/download/2.1.0/EverythingToolbar-2.1.0-x64.exe'
  checksum64     = '17e5a9bffe1f5a9c0664f34d6fb5715e1b86892610b7bd65f544f0a595fcd871'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

