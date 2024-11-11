$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Miru*'
  url64bit       = 'https://github.com/ThaUnknown/miru/releases/download/v5.5.8/win-Miru-5.5.8-installer.exe'
  checksum64     = 'b463d4de0a4597661a4f1b1282e8eb6c139a04c6435445029c7252ddb3dc2686'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
