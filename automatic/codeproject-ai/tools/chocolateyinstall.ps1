$ErrorActionPreference = 'Stop' # stop on all errors

$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $tempPath
  softwareName   = 'CodeProject.AI Server*'
  url64bit       = 'https://www.codeproject.com/KB/Articles/5322557/CodeProject.AI-Server-win-x64-2.6.5.zip'
  checksum64     = '76a56702590bc18e576d3fffb053c0ca8dff5b3db10e5ac7724305f74958e494'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  disableLogging = $true
}

Install-ChocolateyZipPackage @packageArgs

$installerExe = (Get-ChildItem $tempPath -filter "CodeProject.AI*.exe" -File | Select-Object -First 1).FullName
$packageArgs.file64 = $installerExe
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
