$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'KiCad*'
  url64bit       = 'https://github.com/KiCad/kicad-source-mirror/releases/download/10.0.4/kicad-10.0.4-x86_64.exe'
  checksum64     = '0542f21d8f33d4bc530768c97bfe1ecd495a88050b361d1864c12b1e7c9430cd'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'
}

if(Get-Process -Name "kicad" -ea 0) {
  Write-Error "$packageName is running. Please close before upgrading."
}

Install-ChocolateyPackage @packageArgs
