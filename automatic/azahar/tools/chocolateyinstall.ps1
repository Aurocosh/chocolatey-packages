$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2125.1.3/azahar-windows-msvc-2125.1.3-installer.exe'
  checksum64     = '6c89987c3a3d1988242aed7fddae2a8df9172363551e6ee6363ebf26ed90c33b'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

