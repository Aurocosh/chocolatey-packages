$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

# Archive is .tar.gz, and it has to be extracted twice. So we cannot simply use Install-ChocolateyZipPackage to install the program
$archiveFile = Join-Path $packagePath 'archive.tar.gz'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $archiveFile
  softwareName   = 'godu*'
  url            = 'https://github.com/viktomas/godu/releases/download/v1.5.2/godu_1.5.2_windows_386.tar.gz'
  checksum       = 'e81c4e3bc03b3e6c172efb94127c76b5dd8f74e1a29aeff76038f5a50a2e4906'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/viktomas/godu/releases/download/v1.5.2/godu_1.5.2_windows_amd64.tar.gz'
  checksum64     = 'aba3d115f1ce7e028cf346055ed3c5e205670e2907f1f283bc5f87a41cca23e3'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -DisableLogging
Remove-Item -Path $archiveFile -Force

$archiveFile = Join-Path $packagePath 'archive.tar'

Get-ChocolateyUnzip -FileFullPath $archiveFile -Destination $packagePath -PackageName $env:ChocolateyPackageName
Remove-Item -Path $archiveFile -Force

