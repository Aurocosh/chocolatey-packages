$ErrorActionPreference = 'Stop' # stop on all errors

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2119/lime3ds-2119-windows-msvc-installer.exe'
$checksum64msvc = '1171bd0c114b828eaa34bde06f2c8ddb37947f05421703ed3bfef1f1836f9801'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2119/lime3ds-2119-windows-msys2-installer.exe'
$checksum64msys2 = '55431481e69fafab69b7b749f9293226d4d97103e11fa232ec6bdc99ac0830cc'

$PackageParameters = Get-PackageParameters

if ($PackageParameters.MsysVersion) {
  $url64 = $url64msys2
  $checksum64 = $checksum64msys2
}
else {
  $url64 = $url64msvc
  $checksum64 = $checksum64msvc
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Lime3DS*'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
