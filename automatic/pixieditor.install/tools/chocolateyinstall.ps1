$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'PixiEditor*'
  url64bit       = 'https://github.com/PixiEditor/PixiEditor/releases/download/2.1.1.5/PixiEditor-2.1.1.5-setup-x64-win.exe'
  checksum64     = 'd6dd0990a87f6a05eb2d9cf2202b7d2bbac521fcbea4d5e82925016dc2854767'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

