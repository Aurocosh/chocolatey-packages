$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Flow Launcher*'
  url64bit       = 'https://github.com/Flow-Launcher/Flow.Launcher/releases/download/v2.1.3/Flow-Launcher-Setup.exe'
  checksum64     = 'fae25a7c9ea72c51aa7591fe1487b4d1c2d51153e306cbf4c9f87620868bf7e1'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

# Installer launches Flow Launcher after setup; stop it so the install stays silent
Get-Process -Name 'Flow.Launcher' -ErrorAction SilentlyContinue | Stop-Process -Force
