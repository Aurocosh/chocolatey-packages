$ErrorActionPreference = 'Stop'; # stop on all errors

$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $tempPath
  softwareName   = 'XYPlorer*'
  url            = 'https://www.xyplorer.com/free-zer/26.60/xyplorer_full.zip'
  checksum       = '0d192bca703db2f8a3b4818e3db75e13f042a8640541a4cea9e407fdd17f2402'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
  disableLogging = $true
}

Install-ChocolateyZipPackage @packageArgs

$installerExe = (Get-ChildItem $tempPath -filter "XYplorer_*_Install.exe" -File | Select-Object -First 1).FullName
$packageArgs.file = $installerExe
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
