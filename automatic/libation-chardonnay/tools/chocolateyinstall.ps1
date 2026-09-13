$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation (Chardonnay)'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v14.2.1/Libation.14.2.1-windows-chardonnay-x64-setup.exe'
  checksum64     = '3d0a75afd719d9bfdf571ffd8d3a9734649b9aed4b74656db6a7ffe185b9c1b3'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

