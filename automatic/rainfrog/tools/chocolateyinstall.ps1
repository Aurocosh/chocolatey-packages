$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program
$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'rainfrog*'
  url64bit       = 'https://github.com/achristmascarl/rainfrog/releases/download/v0.4.5/rainfrog-v0.4.5-x86_64-pc-windows-msvc.tar.gz'
  checksum64     = '1fe12d9ab5d79eadf3a5c6851cf30e4d75b08f26b2e8e5c8d518de22d7abdb07'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $installPath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force
