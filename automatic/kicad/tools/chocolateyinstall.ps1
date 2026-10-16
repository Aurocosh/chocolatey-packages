$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'KiCad*'
  url64bit       = 'https://github.com/KiCad/kicad-source-mirror/releases/download/10.0.7/kicad-10.0.7-x86_64.exe'
  checksum64     = 'ce3881b6a9188eb34ac1ebaaec7651149e8a025206410addfb11a1a9656ecf95'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'
}

if(Get-Process -Name "kicad" -ea 0) {
  Write-Error "$packageName is running. Please close before upgrading."
}

Install-ChocolateyPackage @packageArgs
