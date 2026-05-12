$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName         = $env:ChocolateyPackageName
  fileType            = 'msi'
  softwareName        = 'Proton Authenticator*'
  url64bit            = 'https://proton.me/download/authenticator/windows/ProtonAuthenticator_1.1.5_x64_en-US.msi'
  checksum64          = '2604858a1a7b4974c237a003104a32208619fdc10ccd48e36bbd33ae5d1b073b'
  checksumType64      = 'sha256'
  validExitCodes      = @(0, 3010, 1641)
  silentArgs          = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

