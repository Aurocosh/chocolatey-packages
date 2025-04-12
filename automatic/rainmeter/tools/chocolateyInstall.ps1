$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Rainmeter*'
  url64bit       = 'https://github.com/rainmeter/rainmeter/releases/download/v4.5.22.3835/Rainmeter-4.5.22.exe'
  checksum64     = '2462569cf24a5a1e313390fa3c52ed05c7f36ef759c4c8f5194348deca022277'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
