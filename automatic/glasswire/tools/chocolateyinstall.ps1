$ErrorActionPreference = 'Stop'

$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36'

# AU Update-Package sets ChocolateyPackageName to 'chocolatey\<id>' while hashing.
# Always use the current 64-bit installer in that mode so AppVeyor (Windows Server)
# does not hash the legacy 3.8.1061 build.
$isAuChecksum = $env:ChocolateyPackageName -like 'chocolatey\*'

$nt = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
$is32BitOs = (Get-OSArchitectureWidth) -eq 32
$isWin7 = $nt.ProductName -match 'Windows 7'
$isServer = $nt.InstallationType -match 'Server' -or $nt.ProductName -match 'Windows Server'
$useLegacy = -not $isAuChecksum -and ($is32BitOs -or $isWin7 -or $isServer)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Glasswire*'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
  Options        = @{
    Headers = @{
      'User-Agent' = $userAgent
    }
  }
}

if ($useLegacy) {
  Write-Host 'Installing GlassWire 3.8.1061 (last version supporting 32-bit Windows, Windows 7, and Windows Server)...'
  $packageArgs.url          = 'https://download.glasswire.com/f/glasswire-setup-3.8.1061-full.exe'
  $packageArgs.checksum     = 'f68b016a9d72ac1d34164ff753803d146ee0a770c94a0e47718a7fb34a4082c2'
  $packageArgs.checksumType = 'sha256'
}
else {
  $packageArgs.url64bit          = 'https://download.glasswire.com/latest/GlassWireSetup.exe?v=3.9.1102'
  $packageArgs.checksum64        = '234cca9e6ee79b7b7d488d21bb80af9828fc6dd9d959feb6b3a305ed31ff73b0'
  $packageArgs.checksumType64    = 'sha256'
}

Install-ChocolateyPackage @packageArgs
