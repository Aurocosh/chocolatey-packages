$ErrorActionPreference = 'Stop'; # stop on all errors

$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $tempPath
  softwareName   = 'XYPlorer*'
  url            = 'https://www.xyplorer.com/free-zer/26.70/xyplorer_full.zip'
  checksum       = '2277b997d4e0d455343ccb559d65359aa8ae59bf67a1868c08746a21651f09ea'
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
