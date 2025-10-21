$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'KiCad*'
  url64bit       = 'https://github.com/KiCad/kicad-source-mirror/releases/download/9.0.5/kicad-9.0.5-x86_64.exe'
  checksum64     = 'fdb86b3e75b08345a05365c10995c9069cd489c44ff4e3d6d3fd22627c6a5f47'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S /allusers'
}

if(Get-Process -Name "kicad" -ea 0) {
  Write-Error "$packageName is running. Please close before upgrading."
}

Install-ChocolateyPackage @packageArgs
