$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2126.1.2/azahar-windows-msvc-2126.1.2-installer.exe'
  checksum64     = '0a0111e0bcfac0dbfdcee7ea4696b053d1b08b52553d273cd40b6ca6998fc12a'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

