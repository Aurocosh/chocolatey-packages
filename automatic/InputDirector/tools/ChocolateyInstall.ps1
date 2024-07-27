$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url            = 'https://inputdirector.com/downloads/InputDirector.v2.2.zip'
  checksum       = 'dd3ffab3cea386a421deaf54dbbf8c175efe0eef0f33e1e759331870e6e6ff5f'
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
