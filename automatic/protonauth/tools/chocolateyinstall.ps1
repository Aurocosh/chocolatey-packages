$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'Proton Authenticator*'
  url            = 'https://proton.me/download/authenticator/windows/ProtonAuthenticator_1.0.0_x64_en-US.msi'
  checksum       = 'd3dc9ec872eac31c2ca3dd8085ae711d98fba3045f854062b7a78ee6f7d8146a'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

