$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2120-rc1/azahar-2120-rc1-windows-msvc-installer.exe'
  checksum64     = 'c06cb2553fe1ffa691af5b00a0a7dd4bf209ebdc9ffb2202db726747a9af621a'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

