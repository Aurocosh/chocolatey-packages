$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Museeks*'
  url64bit       = 'https://github.com/martpie/museeks/releases/download/0.23.3/Museeks_0.23.3_x64-setup.exe'
  checksum64     = '093fe3230cf54126f7c9d474b8411d4d673d495a922529be5f4b91cbf2688d19'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

