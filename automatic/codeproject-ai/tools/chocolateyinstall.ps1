$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$archiveFile = Join-Path $packagePath 'CodeProject.AI.zip'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'CodeProject.AI Server*'
  url64bit       = 'https://www.codeproject.com/KB/Articles/5322557/CodeProject.AI-Server-win-x64-2.6.5.zip'
  checksum64     = '76a56702590bc18e576d3fffb053c0ca8dff5b3db10e5ac7724305f74958e494'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$installerExe = (Get-ChildItem $packagePath -filter "CodeProject.AI-Server-win-x64-*.exe" -File | Select-Object -First 1).FullName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'CodeProject.AI Server*'
  file64         = $installerExe
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Path $installerExe -Force
