$ErrorActionPreference = 'Stop'

$os = Get-CimInstance Win32_OperatingSystem
$is32BitOs = (Get-OSArchitectureWidth) -eq 32
$isWin7 = $os.Caption -match 'Windows 7'
$isServer = $os.ProductType -ne 1

$useLegacy = $is32BitOs -or $isWin7 -or $isServer

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Glasswire*'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

if ($useLegacy) {
  Write-Host 'Installing GlassWire 3.8.1061 (last version supporting 32-bit Windows, Windows 7, and Windows Server)...'
  $packageArgs.url          = 'https://s3.us-east-1.amazonaws.com/s3.glasswire.com/download/GlassWireSetup.exe'
  $packageArgs.checksum     = 'f68b016a9d72ac1d34164ff753803d146ee0a770c94a0e47718a7fb34a4082c2'
  $packageArgs.checksumType = 'sha256'
}
else {
  $packageArgs.url64bit          = 'https://s3.us-east-1.amazonaws.com/s3.glasswire.com/download/42355969649152f92738c28f050453e3/GlassWireSetup.exe'
  $packageArgs.checksum64        = '47780711f5c5e0316c7ecd5926ea8d43f74e7d333310407bed5525f6f482d5c0'
  $packageArgs.checksumType64    = 'sha256'
}

Install-ChocolateyPackage @packageArgs
