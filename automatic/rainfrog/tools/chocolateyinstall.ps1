$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program
$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'rainfrog*'
  url64bit       = 'https://github.com/achristmascarl/rainfrog/releases/download/v0.3.19/rainfrog-v0.3.19-x86_64-pc-windows-msvc.tar.gz'
  checksum64     = '5cb8fd69203c8e11b29a7bcaa4f71b76992a835b486b7109bdfc1c3c5f2c1ce0'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $installPath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force
