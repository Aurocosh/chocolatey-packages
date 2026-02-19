$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program
$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'rainfrog*'
  url64bit       = 'https://github.com/achristmascarl/rainfrog/releases/download/v0.3.16/rainfrog-v0.3.16-x86_64-pc-windows-msvc.tar.gz'
  checksum64     = 'f4c0424576f1a346dd8697b72bd9c2e24868f89b406ce5a45aea29b5856ac2e5'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $installPath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force
