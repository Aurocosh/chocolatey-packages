$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Zen Browser*'
  url64bit       = 'https://github.com/zen-browser/desktop/releases/download/1.12.7b/zen.installer.exe'
  checksum64     = '17d03d2ce0d4c11fe7f3654c05705f4050926b53665f3157062a20fc08322b79'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs
