$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Proxy Checker*'
  url            = 'https://vovsoft.com/files/proxy-checker.exe?v=1.3'
  checksum       = 'dda514ac8024e421cd1b234aadbba7bbbe9ed49b4f715e223b4aeb958a3d645d'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
