$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2124.3/azahar-2124.3-windows-msvc-installer.exe'
  checksum64     = 'a4f94541d1a8de8b6addb604a351c75e7f4d24bcb5dcc88bfdc6320af7f9a2c7'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

