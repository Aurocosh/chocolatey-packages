$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  softwareName   = 'CDisplayEx*'
  url            = 'https://www.cdisplayex.com/files/CDXWin32v1.10.33.exe'
  checksum       = '3777afbc649901be6948bcd22f97f1c1d0f77c6375f5a027a88a62a75e5eecda'
  checksumType   = 'sha256'
  url64bit       = 'https://www.cdisplayex.com/files/CDXWin64v1.10.33.exe'
  checksum64     = '38352a6240b3407b43c6b21d70d0ec5fca12592ab68b869cbfa9a8efc8d36cff'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
