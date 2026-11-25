$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'azahar*'
  url64bit       = 'https://github.com/azahar-emu/azahar/releases/download/2127.0.1/azahar-windows-msvc-2127.0.1-installer.exe'
  checksum64     = 'eaa508706cc46abad502069231aa9a7d79d5fe6fddd892afc9d5d5b4169ec815'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

