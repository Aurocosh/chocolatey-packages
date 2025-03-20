$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program

$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'cog'
  url64bit       = 'https://github.com/cocogitto/cocogitto/releases/download/6.3.0/cocogitto-6.3.0-x86_64-pc-windows-msvc.tar.gz'
  checksum64     = 'df66dc5cc1bc79c0b44ef2ef631824c59e00b00951c8add61d7c6b076ef907f2'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force
