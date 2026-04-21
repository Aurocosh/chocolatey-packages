$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2125.1.1/azahar-windows-msvc-2125.1.1-installer.exe'
  checksum64     = 'eaefbddec01dd2a794f9d24fb1505ca4b045ec7c2127e5a214c54b5307d21bd9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

