$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Chardonnay)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v13.7.2/Libation.13.7.2-windows-chardonnay-x64-setup.exe'
  checksum64     = 'cfc52e5ab330ba3b8a05de7a5c1a68b03eacd37964cd4d01093b95cb3615d0b2'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

