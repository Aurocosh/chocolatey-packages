$ErrorActionPreference = 'Stop'; # stop on all errors

$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $tempPath
  softwareName   = 'XYPlorer*'
  url            = 'https://www.xyplorer.com/free-zer/26.70/xyplorer_full.zip'
  checksum       = '6e52a31be21ed1cf080001b37ba0c754fc87079eed3ba145f708b5f645f3d9be'
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
