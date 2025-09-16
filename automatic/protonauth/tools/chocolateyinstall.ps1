$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName         = $env:ChocolateyPackageName
  fileType            = 'msi'
  softwareName        = 'Proton Authenticator*'
  url64bit            = 'https://proton.me/download/authenticator/windows/ProtonAuthenticator_1.1.4_x64_en-US.msi'
  checksum64          = 'fd6503822f1d1f2897964d1401be3abb3ff7f0d19cd3ac69e8897badb38120de'
  checksumType64      = 'sha256'
  validExitCodes      = @(0, 3010, 1641)
  silentArgs          = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

