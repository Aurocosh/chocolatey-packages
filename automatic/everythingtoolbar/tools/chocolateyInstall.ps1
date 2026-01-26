$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'EverythingToolbar*'
  url64bit       = 'https://github.com/srwi/EverythingToolbar/releases/download/2.1.2/EverythingToolbar-2.1.2-x64.exe'
  checksum64     = '3cb32b5471685186034f3e62fce22df89d53231b310155a80a5149667c5b768a'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs

