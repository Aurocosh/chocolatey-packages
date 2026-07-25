$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program
$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'rainfrog*'
  url64bit       = 'https://github.com/achristmascarl/rainfrog/releases/download/v0.4.1/rainfrog-v0.4.1-x86_64-pc-windows-msvc.tar.gz'
  checksum64     = '339b629aa3ad8c2fb0cbac4400699d404e96e8f5ba02d883d264b7aba5726b4d'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $installPath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force
