$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'KiCad*'
  url64bit       = 'https://github.com/KiCad/kicad-source-mirror/releases/download/9.0.8/kicad-9.0.8-x86_64.exe'
  checksum64     = 'f853f81dd6a90c769c521a35c438c5657fe39aaebe9967c8a74e743540920eb5'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'
}

if(Get-Process -Name "kicad" -ea 0) {
  Write-Error "$packageName is running. Please close before upgrading."
}

Install-ChocolateyPackage @packageArgs
