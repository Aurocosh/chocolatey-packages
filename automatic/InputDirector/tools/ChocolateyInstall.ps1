$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url            = 'https://inputdirector.com/downloads/InputDirector.v2.3.zip'
  checksum       = '51316c7993058fb7973f2a24523aabe7da66c08e89511486fc924f030c9af538'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
  disableLogging = $true
}

Install-ChocolateyZipPackage @packageArgs

$installerExe = (Get-ChildItem $toolsDir -filter "InputDirector.v*.build*.Domain.Setup.exe" -File | Select-Object -First 1).FullName
$packageArgs.file = $installerExe
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $installerExe -Force -ErrorAction SilentlyContinue
