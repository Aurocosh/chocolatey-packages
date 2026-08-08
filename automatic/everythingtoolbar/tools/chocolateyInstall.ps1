$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'EverythingToolbar*'
  url64bit       = 'https://github.com/srwi/EverythingToolbar/releases/download/3.1.0/EverythingToolbar-3.1.0-x64.exe'
  checksum64     = '0d15ddaeffcfac7375259db888c2fa4803d7c6a1b9c97a5d0cf08b5a9fb471fa'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

