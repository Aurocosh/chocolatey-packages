$ErrorActionPreference = 'Stop' # stop on all errors

$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $tempPath
  softwareName   = 'CodeProject.AI Server*'
  url64bit       = 'https://codeproject-ai-bunny.b-cdn.net/server/installers/win/CodeProject.AI-Server_2.9.5_win_x64.zip'
  checksum64     = '2d1ae5d45c48ec9906cde431b4328d3b928bb77b85fc8e3424552170f1b2e5e9'
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
