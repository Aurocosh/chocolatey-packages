$ErrorActionPreference = 'Stop' # stop on all errors

$url64msvc = 'https://github.com/Lime3DS/Lime3DS/releases/download/2118/lime3ds-2118-windows-msvc.zip'
$checksum64msvc = '62700c4659b770e4f733447453086fcb7b413a24c45a1f2321f41ed6d439afe5'

$url64msys2 = 'https://github.com/Lime3DS/Lime3DS/releases/download/2118/lime3ds-2118-windows-msys2.zip'
$checksum64msys2 = 'cb494999d140fd6c8d8880f4cd31e31ab7876e2fc03d69053ef097bf51a5d05f'

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
