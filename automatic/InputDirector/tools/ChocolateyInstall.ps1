$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url            = 'https://inputdirector.com/downloads/InputDirector.v2.4.zip'
  checksum       = '61906a72291dbc428e01fc064bf7ace54e2db78f5d35caa5ffab9e5d061830a5'
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
