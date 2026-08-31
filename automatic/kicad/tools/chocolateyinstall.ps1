$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'KiCad*'
  url64bit       = 'https://github.com/KiCad/kicad-source-mirror/releases/download/10.0.6/kicad-10.0.6-x86_64.exe'
  checksum64     = '9e24dc47119f7c472128c2f293c5e3f35569274a44c905e60a7514d47c16ce48'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'
}

if(Get-Process -Name "kicad" -ea 0) {
  Write-Error "$packageName is running. Please close before upgrading."
}

Install-ChocolateyPackage @packageArgs
