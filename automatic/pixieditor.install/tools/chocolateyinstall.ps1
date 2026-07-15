$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'PixiEditor*'
  url64bit       = 'https://github.com/PixiEditor/PixiEditor/releases/download/2.1.1.4/PixiEditor-2.1.1.4-setup-x64-win.exe'
  checksum64     = '83a0adb65a409a0d408e00be3a242b13f0a563a95f86fa2c0d22ccc3bb3aad62'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

