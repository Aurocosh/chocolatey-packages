$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName         = $env:ChocolateyPackageName
  fileType            = 'msi'
  softwareName        = 'Proton Authenticator*'
  url64bit            = 'https://proton.me/download/authenticator/windows/ProtonAuthenticator_1.1.3_x64_en-US.msi'
  checksum64          = '17f2378ab4ca1b68632f59bf34d9f9762f14f8ceb655585ad0102043fbfb7f84'
  checksumType64      = 'sha256'
  validExitCodes      = @(0, 3010, 1641)
  silentArgs          = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

