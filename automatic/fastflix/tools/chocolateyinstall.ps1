$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'FastFlix*'
  url64bit       = 'https://github.com/cdgriffith/FastFlix/releases/download/6.2.1/FastFlix_6.2.1_installer.exe'
  checksum64     = 'aba54b037cc56cdd92144ebcbae0718f6f602cc34bd6451518f01ecb0b3d5e18'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
