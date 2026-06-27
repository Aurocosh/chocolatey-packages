$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Libation Classic*'
  url64bit       = 'https://github.com/rmcrackan/Libation/releases/download/v13.5.0/Libation-Classic.13.5.0-windows-classic-x64-setup.exe'
  checksum64     = '026e638e97200557451b7bd06e0ad7bd2a0605068383f3569af966a81befce0d'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

