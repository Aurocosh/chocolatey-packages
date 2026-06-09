$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName         = $env:ChocolateyPackageName
  fileType            = 'msi'
  softwareName        = 'Proton Authenticator*'
  url64bit            = 'https://proton.me/download/authenticator/windows/ProtonAuthenticator_1.1.6_x64_en-US.msi'
  checksum64          = '52e5c0b28be769910fbbf24724f552ed4a75dd8571be1004dcf6992fba3a2cb5'
  checksumType64      = 'sha256'
  validExitCodes      = @(0, 3010, 1641)
  silentArgs          = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

