$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'PixiEditor*'
  url64bit       = 'https://github.com/PixiEditor/PixiEditor/releases/download/2.1.2.4/PixiEditor-2.1.2.4-setup-x64-win.exe'
  checksum64     = '98436fe7e5cefea7115511ca2af97db6fb07da6ddf54c144bca2fc1dd6bd5b36'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

