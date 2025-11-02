$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program

$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'cog'
  url64bit       = 'https://github.com/cocogitto/cocogitto/releases/download/6.5.0/cocogitto-6.5.0-x86_64-pc-windows-msvc.tar.gz'
  checksum64     = 'ee4570d25e31393b88518af570f54e97f89e07346d545809e0c7404e8d076245'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force
