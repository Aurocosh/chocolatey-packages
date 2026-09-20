$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Flow Launcher*'
  url64bit       = 'https://github.com/Flow-Launcher/Flow.Launcher/releases/download/v2.1.4/Flow-Launcher-Setup.exe'
  checksum64     = '0e7b4ea82192702a98a10f8ec257c3830f6591b80517d291a83854c0df54fc20'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

# Installer launches Flow Launcher after setup; stop it so the install stays silent
Get-Process -Name 'Flow.Launcher' -ErrorAction SilentlyContinue | Stop-Process -Force
