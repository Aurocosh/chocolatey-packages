$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  url64bit       = 'https://github.com/xgi/houdoku/releases/download/v2.14.0/Houdoku-Setup-2.14.0.exe'
  softwareName   = 'houdoku*'
  checksum64     = 'eaeedada2f4580b503c24cad2daeb9e6ac33689e8764f95aff0120cf07333881'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
