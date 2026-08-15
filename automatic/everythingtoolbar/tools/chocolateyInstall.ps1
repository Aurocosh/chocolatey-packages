$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'EverythingToolbar*'
  url64bit       = 'https://github.com/srwi/EverythingToolbar/releases/download/3.2.0/EverythingToolbar-3.2.0-x64.exe'
  checksum64     = 'fc512c667fc9960a94a62fa590f20b0e42d4b1f354a2cfdbdde24101f867b8dc'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

