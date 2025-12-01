$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program
$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'rainfrog*'
  url64bit       = 'https://github.com/achristmascarl/rainfrog/releases/download/v0.3.10/rainfrog-v0.3.10-x86_64-pc-windows-msvc.tar.gz'
  checksum64     = '4b7b17110b3171f00ef5b28e9937f54646c10637a9e157d8b286a0a9be97cd6f'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $installPath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force
